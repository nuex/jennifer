# jen-validate.awk
#
# Validates a jen template
#
/^name / { name = "yes" }
/^description / { description = "yes" }

END {
  if (!name) error("name required")
  if (!description) error("description required")
  if (errors) exit 1
}

function error(s) {
  errors = "yes"
  printf("Invalid template \"" FILENAME "\": %s\n", s);
  exit 1
}
