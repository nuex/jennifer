# jen-list.awk
#
# Generates a formatted list of installed jennifer templates.
# This script expects to be passed a list of template files.
#
BEGIN {
  lcnt = 0
  width = 0
}

FNR == 1 {
  lcnt++
}

/^name/ {
  sub(/^name /, "", $0)
  names[lcnt] = $0

  # Track the widest name for fixed-width output
  if (length($0) > width) {
    width = length($0) + 5
  }

}

/^description/ {
  sub(/^description /, "", $0)
  descriptions[lcnt] = $0
}

END {
  for (i=0; i<=lcnt; i++) {
    if (names[i] && descriptions[i]) {
      printf "%-" width "s" "%s\n", names[i], descriptions[i]
    }
  }
}
