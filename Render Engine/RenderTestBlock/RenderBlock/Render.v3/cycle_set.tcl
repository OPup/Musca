
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /Render/core/main/io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
