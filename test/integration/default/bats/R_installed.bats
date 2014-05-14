#!/usr/bin/env bats
@test "R development version binary is found in PATH" {
    run which R
    [ "$status" -eq 0 ]
}
