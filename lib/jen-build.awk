# jen-build.awk
#
# Generate a project skeleton from a jennifer template
#

# Parse passed in vars
FILENAME == "-" {
  set_custom_data($0)
  next
}

# var command
/^var / {
  k = $2
  v = ""
  for (i=3; i<=NF; i++) {
    if (v) {
      v = v " " $i
    } else {
      v = $i
    }
  }

  # If there was custom data set with this key,
  # overwrite the template version
  if (custom_data[k]) v = custom_data[k]

  data[k] = v
  next
}

# collect commands
/^(dir|cp|template)/ {
  commands[command_cnt++] = $0
}

END {
  bind_vars()
  build()
}

# Bind data to a text string template
function bind_data(s,   tag, key) {
  if (match(s, /{{([^}]*)}}/)) {
    tag = substr(s, RSTART, RLENGTH)
    match(tag, /([[:alnum:]_]|[?]).*[^}]/)
    key = substr(tag, RSTART, RLENGTH)
    gsub(tag, data[key], s)
    return bind_data(s)
  } else {
    return s
  }
}

# Bind data to tags in vars
function bind_vars() {
  for (k in data) {
    data[k] = bind_data(data[k])
  }
}

# Scrape off inline comments and reset $0 and NF
function scrub_comments() {
  if (match($0, /;/)) {
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
}

# From a comma separated list of key value pairs, build
# the associative data array.
function set_custom_data(vars) {
  split(vars, pairs, ",")
  for (i=1; i<=length(pairs); i++) {
    split(pairs[i], kv, "=")
    custom_data[kv[1]] = kv[2]
  }
}

# Generate the project
function build() {
  for (idx in commands) {
    $0 = commands[idx]
    if ($0 ~ /^dir/) run_dir()
    if ($0 ~ /^cp/) run_cp()
    if ($0 ~ /^template/) run_template()
  }
}

# Create a directory
function run_dir() {
  dir = bind_data($2)
  system("mkdir -p " dir)
}

# Copy a file
function run_cp() {
  src = $2
  dst = bind_data($3)
  system("cp " template_dir "/" src " " dst)
}

# Create a template
function run_template() {
  src = template_dir "/" $2
  destination = bind_data($3)

  # Pull each line out of the file and bind
  # data to any template tags
  rendered = read_file(src)
  close(src)

  # Pipe rendered text to the destination file
  print rendered > destination
}

# Read a file and return the data
function read_file(file,      rendered, line, rendered_line) {
  rendered = ""
  while ((getline line < file) > 0) {
    rendered_line = bind_data(line)
    if (length(rendered) > 0) {
      rendered = rendered "\n" rendered_line
    } else {
      rendered = rendered_line
    }
  }
  return rendered
}
