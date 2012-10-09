# jen-build.awk
#
# Generate a project skeleton from a jennifer template
#

# Ignore blank lines and comments
NF == 0 || $0 ~ /^;/ { next }

# Parse passed in vars
FILENAME == "-" {
  set_custom_data($0)
  next
}

{ scrub_comments() }

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
  data[k] = v

  # If there was custom data set with this key,
  # overwrite the template version
  if (custom_data[k]) {
    data[k] = custom_data[k]
  }
  next
}

# dir command
/^dir / {
  dir = bind_data($2)
  system("mkdir -p " dir)
}

# cp command
/^cp / {
  src = $2
  dst = bind_data($3)
  system("cp " template_dir "/" src " " dst)
}

# template command
/^template / {
  src = template_dir "/" $2
  destination = bind_data($3)

  # Pull each line out of the file and bind
  # data to any template tags
  rendered = ""
  while ((getline line < src) > 0) {
    if (rendered) {
      rendered = rendered "\n" bind_data(line)
    } else {
      rendered = bind_data(line)
    }
  }
  close(src)

  # Pipe rendered text to the destination file
  print rendered > destination

  next
}

# Bind data to a text string template
function bind_data(s,   tag, key) {
  if (match(s, /{{([^}]*)}}/)) {
    tag = substr(s, RSTART, RLENGTH)
    match(tag, /([[:alnum:]_]|[?]).*[^}]/)
    key = substr(tag, RSTART, RLENGTH)
    gsub(tag, data[key], s)
    return bind_data(s, data)
  } else {
    return s
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
