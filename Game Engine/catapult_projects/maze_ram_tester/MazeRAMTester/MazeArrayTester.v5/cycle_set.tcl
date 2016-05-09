
# Loop constraints
directive set /MazeArrayTester/core/core:rlp CSTEPS_FROM {{. == 1}}
directive set /MazeArrayTester/core/core:rlp/main CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/if:for CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /MazeArrayTester/core/core:rlp/main/if:io_write(write:rsc.d) CSTEPS_FROM {{.. == 0}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for/if:for:for:io_write(row:rsc.d) CSTEPS_FROM {{.. == 0}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for/if:for:for:io_write(col:rsc.d) CSTEPS_FROM {{.. == 0}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for/if:for:for:if:io_write(out:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/else#1:io_write(write:rsc.d) CSTEPS_FROM {{.. == 0}}

# Real operation constraints
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for/if:for:for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:for/if:for:for:acc CSTEPS_FROM {{.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /MazeArrayTester/core/core:rlp/main/if:for/if:for:acc CSTEPS_FROM {{.. == 1}}
