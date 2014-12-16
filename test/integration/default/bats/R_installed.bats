#!/usr/bin/env bats
@test "R development version binary is found in PATH" {
    run ls /usr/local/R/3.1.2/bin/R
    [ "$status" -eq 0 ]
}
