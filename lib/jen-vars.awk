# jen-var.awk
#
# List variables available for a template.
#
BEGIN {
  FS = " "
}

/^var/ && NF > 1 {
  var = $2
  def = $3
  line = "var " var
  if (NF > 2) line = line " [" def "]"
  print line
}
