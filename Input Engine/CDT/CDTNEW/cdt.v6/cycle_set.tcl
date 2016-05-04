
# Loop constraints
directive set /cdt/core/main CSTEPS_FROM {{. == 2}}

# IO operation constraints
directive set /cdt/core/main/H_IN:io_read(H_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/S_IN:io_read(S_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/V_IN:io_read(V_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/io_write(R_OUT:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/io_write(G_OUT:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/io_write(B_OUT:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /cdt/core/main/acc CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if:if:acc CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if:oelse:acc CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/aif#2:acc CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /cdt/core/main/if#1:aif:acc CSTEPS_FROM {{.. == 1}}
