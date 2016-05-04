
# Loop constraints
directive set /Render/core/main CSTEPS_FROM {{. == 1}}
directive set /Render/core/main/for CSTEPS_FROM {{. == 2} {.. == 1}}

# IO operation constraints
directive set /Render/core/main/for/for:io_write(v_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /Render/core/main/for/for:acc#6 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#5 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#9 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#8 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#7 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/acc CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#12 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#13 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc#4 CSTEPS_FROM {{.. == 1}}
directive set /Render/core/main/for/for:acc CSTEPS_FROM {{.. == 1}}
