
# Loop constraints
directive set /RAM_BLOCK/core/core:rlp CSTEPS_FROM {{. == 1}}
directive set /RAM_BLOCK/core/core:rlp/data:vinit CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main CSTEPS_FROM {{. == 3} {.. == 1}}

# IO operation constraints
directive set /RAM_BLOCK/core/core:rlp/main/row:io_read(row:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/col:io_read(col:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/data_in:io_read(data_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/io_read(write:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/if:io_write(data_out:rsc.d)#1 CSTEPS_FROM {{.. == 2}}

# Real operation constraints
directive set /RAM_BLOCK/core/core:rlp/data:vinit/if:write_mem(data:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/data:vinit/if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/if:write_mem(data:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/else:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/else:read_mem(data:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RAM_BLOCK/core/core:rlp/main/mux CSTEPS_FROM {{.. == 2}}
