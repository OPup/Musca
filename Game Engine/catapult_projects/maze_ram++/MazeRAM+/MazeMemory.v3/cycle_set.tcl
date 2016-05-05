
# Loop constraints
directive set /MazeMemory/core/core:rlp CSTEPS_FROM {{. == 1}}
directive set /MazeMemory/core/core:rlp/maze:vinit CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /MazeMemory/core/core:rlp/main CSTEPS_FROM {{. == 3} {.. == 1}}

# IO operation constraints
directive set /MazeMemory/core/core:rlp/main/row:io_read(row:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/col:io_read(col:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/val:io_read(val:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/io_read(write:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:io_write(out:rsc.d)#1 CSTEPS_FROM {{.. == 2}}

# Real operation constraints
directive set /MazeMemory/core/core:rlp/maze:vinit/if:write_mem(maze:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/maze:vinit/if:acc CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:write_mem(maze:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/else:read_mem(maze:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/mux CSTEPS_FROM {{.. == 2}}
