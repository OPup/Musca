
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 1}}
directive set /Render/core/main/for CSTEPS_FROM {{. == 1} {.. == 1}}

# IO operation constraints
directive set /Render/core/main/for/for:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 0}}

# Real operation constraints
directive set /Render/core/main/for/for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc CSTEPS_FROM {{.. == 1}}
