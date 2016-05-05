
# Loop constraints
directive set /Counter/core/main CSTEPS_FROM {{. == 1}}
directive set /Counter/core/main/for CSTEPS_FROM {{. == 1} {.. == 1}}
directive set /Counter/core/main/for/for:for CSTEPS_FROM {{. == 1} {.. == 0}}

# IO operation constraints
directive set /Counter/core/main/for/for:for/for:for:io_write(col_count:rsc.d) CSTEPS_FROM {{.. == 0}}
directive set /Counter/core/main/for/for:for/for:for:io_write(row_count:rsc.d) CSTEPS_FROM {{.. == 0}}

# Real operation constraints
directive set /Counter/core/main/for/for:for/for:for:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /Counter/core/main/for/for:acc#1 CSTEPS_FROM {{.. == 1}}
