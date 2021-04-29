#!/usr/bin/env python

# \033[0;31m red
# \033[0;31;47m red with white background
# \033[0;32m green
# \033[0;32;47m green with white background

# \033[0;31m red
# \033[0;31;44m red with blue background
# \033[0;32m green
# \033[0;32;44m green with blue background

import sys
import signal
import string

class DiffColorer(object):

    def reset(self):
        self.esc_diff = '\033[0;35m'
        self.esc_hunk = '\033[0;36m'
        self.esc_add = '\033[0;32m'
        self.esc_addh = '\033[0;32;44m'
        self.esc_rem = '\033[0;31m'
        self.esc_remh = '\033[0;31;44m'
        self.esc_tws = '\033[0;41m'
        self.esc_off = '\033[0;0m'
        self.overflow = 0
        self.maxLines = 100000
        self.addLines = []
        self.remLines = []

    def bufferAdd(self, line, fout):
        if len(self.addLines) + len(self.remLines) >= self.maxLines:
            self.flush(fout, False)
            self.overflow = 1
        if self.overflow:
            ws = self.trailingWhitespaceIndex(line)
            if ws:
                last = ws + len(line)
                line = line[:last] + self.esc_tws + line[last:]
            fout.write(self.wrap(line, self.esc_add) + '\n')
        else:
            self.addLines.append(line)

    def bufferRem(self, line, fout):
        if len(self.addLines) + len(self.remLines) >= self.maxLines:
            self.flush(fout, False)
            self.overflow = 1
        if self.overflow:
            fout.write(self.wrap(line, self.esc_rem) + '\n')
        else:
            self.remLines.append(line)

    def flush(self, fout, formatWords=True):
        if formatWords and len(self.remLines) == len(self.addLines):
            for i in range(0, len(self.remLines)):
                (rem, add) = self.diffLines(self.remLines[i], self.addLines[i])
                self.remLines[i] = rem
                self.addLines[i] = add
        for l in self.remLines:
            fout.write(self.wrap(l, self.esc_rem) + '\n')
        for l in self.addLines:
            ws = self.trailingWhitespaceIndex(l)
            if ws:
                last = ws + len(l)
                l = l[:last] + self.esc_tws + l[last:]
            fout.write(self.wrap(l, self.esc_add) + '\n')
        self.remLines = []
        self.addLines = []
        self.overflow = 0

    def wrap(self, line, esc):
        return '%s%s%s' % (esc, line, self.esc_off)

    def color(self, fin, fout):
        self.reset()
        for line in fin:
            line = line.rstrip('\n')
            if line.startswith('+++'):
                self.flush(fout)
                fout.write(self.wrap(line, self.esc_add) + '\n')
            elif line.startswith('---'):
                self.flush(fout)
                fout.write(self.wrap(line, self.esc_rem) + '\n')
            elif line.startswith('+'):
                self.bufferAdd(line, fout)
            elif line.startswith('-'):
                self.bufferRem(line, fout)
            elif line.startswith('@@'):
                self.flush(fout)
                fout.write(self.wrap(line, self.esc_hunk) + '\n')
            elif line.startswith('diff '):
                self.flush(fout)
                fout.write(self.wrap(line, self.esc_diff) + '\n')
            else:
                self.flush(fout)
                fout.write(line + '\n')
        self.flush(fout)
        self.reset()

    def diffLines(self, rem, add):
        (start, end) = self.lineChangeIndexes(rem[1:], add[1:])
        ws = self.trailingWhitespaceIndex(add[1:])
        if start or end:
            start += 1
            last = end + len(rem)
            rem = rem[:start] + self.esc_remh + rem[start:last] + self.esc_rem + rem[last:]
            end = min(end, ws)
            last = end + len(add)
            add = add[:start] + self.esc_addh + add[start:last] + self.esc_add + add[last:]
        if ws:
            add = add[:ws] + self.esc_tws + add[ws:]
        return (rem, add)


    @classmethod
    def trailingWhitespaceIndex(cls, line):
        """
        Return a negative offset at which trailing whitespace starts. Return 0 when
        no trailing whitespace is found.
        """
        i = 0
        limit = -len(line)
        while i-1 >= limit and line[i-1] in string.whitespace:
            i -= 1
        return i

    @classmethod
    def lineChangeIndexes(cls, line1, line2):
        """
        Return postive offset at which changes start, and negative offset at which
        changes end. Return (0, 0) when neither a common prefix or suffix is found.
        """
        (start, end) = (0, 0)
        limit1 = min(len(line1), len(line2))
        while start < limit1 and line1[start] == line2[start]:
            start += 1
        limit2 = start - limit1
        while end-1 >= limit2 and line1[end-1] == line2[end-1]:
            end -= 1

        # for simple inserts/deletes, try shifting the changed range
        # to the left in order to align spacing
        wc = string.digits + string.ascii_letters
        ll = max([line1, line2], key=len)
        if start and end and (start - end) >= limit1 and (ll[start-1] in wc or ll[end-1] in wc):
            (s, e) = (start-1, end-1)
            while s >= 0 and ll[s] == ll[e]:
                if ((s == 0 and ll[e-1] not in wc) or
                (s > 0 and ll[s-1] not in wc and ll[e-1] not in wc)):
                    (start, end) = (s, e)
                    break
                (s, e) = (s-1, e-1)

        return (start, end)


def handleSigpipe(signum, frame):
    sys.exit(0)


def main(argv=None):
    if argv is None:
        argv = sys.argv

    if '-h' in argv or '--help' in argv:
        print >>sys.stderr, "Help summary here"
        print >>sys.stderr, ""
        print >>sys.stderr, "usage: command | %s " % argv[0]
        return 1

    # process
    try:
        signal.signal(signal.SIGPIPE, handleSigpipe)
        dc = DiffColorer()
        dc.color(sys.stdin, sys.stdout)
    except Exception as err:
        print >>sys.stderr, err
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())

