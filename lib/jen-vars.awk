# jen-var.awk
#
# List variables available for a template.
#
BEGIN {
  FS = " "
}

/^var/ && NF > 1 {
  var = $2
  if (length(NF) == 2) {
    print var
    next
  }
  def = $3
  line = "var " var
  if (length(def) > 0) {
    line = line " [" def "]"
  }
  print line
}
