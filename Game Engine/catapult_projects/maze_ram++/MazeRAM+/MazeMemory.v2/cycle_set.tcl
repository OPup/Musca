
# Loop constraints
directive set /MazeMemory/core/core:rlp CSTEPS_FROM {{. == 1}}
directive set /MazeMemory/core/core:rlp/maze:vinit CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /MazeMemory/core/core:rlp/main CSTEPS_FROM {{. == 3} {.. == 1}}

# IO operation constraints
directive set /MazeMemory/core/core:rlp/main/row:io_read(row:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/col:io_read(col:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/val:io_read(val:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/write:io_read(write:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/io_read(init:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:if:io_write(out:rsc.d)#1 CSTEPS_FROM {{.. == 2}}

# Real operation constraints
directive set /MazeMemory/core/core:rlp/maze:vinit/if:if:write_mem(maze:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/maze:vinit/if:if:acc CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:if:write_mem(maze:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:else:read_mem(maze:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /MazeMemory/core/core:rlp/main/if:mux CSTEPS_FROM {{.. == 2}}
