# jen-list.awk
#
# Generates a formatted list of installed jennifer templates.
# This script expects to be passed a list of template files.
#
BEGIN { line = "" }

/^name/ {
  sub(/^name /, "", $0);
  line = $0
}

/^description/ {
  sub(/^description /, "", $0);
  line = line " - " $0
}

END { print line }
