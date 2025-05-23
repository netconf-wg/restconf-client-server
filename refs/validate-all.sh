#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-restconf-client\@*.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 ietf-restconf-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-restconf-server\@*.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 ietf-restconf-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-restconf-client\@*.yang (yanglint)..."
command="yanglint -t config --features=ietf-http-client:http1-supported ietf-restconf-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-restconf-server\@*.yang (yanglint)..."
command="yanglint -t config ietf-restconf-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-restconf-client.xml..."
command="yanglint -t config -ii -m ietf-restconf-client\@*.yang ex-restconf-client.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-restconf-server.xml..."
command="yanglint -t config -ii -m ietf-restconf-server\@*.yang ex-restconf-server.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
