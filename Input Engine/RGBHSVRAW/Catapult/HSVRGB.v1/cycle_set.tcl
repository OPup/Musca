
# Loop constraints
directive set /HSVRGB/core/main CSTEPS_FROM {{. == 11}}

# IO operation constraints
directive set /HSVRGB/core/main/R_IN:io_read(R_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/G_IN:io_read(G_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/B_IN:io_read(B_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/io_write(H_OUT:rsc.d) CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/io_write(S_OUT:rsc.d) CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/io_write(V_OUT:rsc.d) CSTEPS_FROM {{.. == 10}}

# Real operation constraints
directive set /HSVRGB/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#1:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/mux1h CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if#3:acc CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if#3:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#5:if:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/mux1h#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/if#7:equal CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:acc#3 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:and#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:and#3 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:equal CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:if#1:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:equal CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:if:acc#1 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:else#1:else:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:else:div CSTEPS_FROM {{.. == 1}}
directive set /HSVRGB/core/main/else#7:else#1:else:acc#1 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:mux1h CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:acc#2 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:if#2:acc CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/else#7:mux#7 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/and#1 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/and#2 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/and CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/mul#1 CSTEPS_FROM {{.. == 10}}
directive set /HSVRGB/core/main/mul CSTEPS_FROM {{.. == 1}}
