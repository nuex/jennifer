# jen-internal.awk
#
# General functions and clauses used across multiple awk libraries
#

# Ignore blank lines and comments
NF == 0 || $0 ~ /^;/ { next }

# Scrape off inline comments and reset $0 and NF
/;/ {
  comment_start = RSTART
  line = $0
  for (i = 1; i <= NF; i++) {
    if ($i ~ /^;/) {
      NF = NF - ((NF + 1) - i)
      $0 = substr(line, 0, comment_start - 1)
      break
    }
  }
}
