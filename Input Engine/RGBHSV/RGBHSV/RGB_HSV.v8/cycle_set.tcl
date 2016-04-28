
# Loop constraints
directive set /RGB_HSV/core/main CSTEPS_FROM {{. == 4}}

# IO operation constraints
directive set /RGB_HSV/core/main/R_IN:io_read(R_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/G_IN:io_read(G_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/B_IN:io_read(B_IN:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:io_write(H_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}
directive set /RGB_HSV/core/main/if:if#1:io_write(S_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}
directive set /RGB_HSV/core/main/if:if#1:io_write(V_OUT:rsc.d) CSTEPS_FROM {{.. == 3}}

# Real operation constraints
directive set /RGB_HSV/core/main/if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:acc#2 CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:else:else:if:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:mux1h CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:mux1h#1 CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:acc CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:if#1:div CSTEPS_FROM {{.. == 1}}
directive set /RGB_HSV/core/main/if:if#1:and#1 CSTEPS_FROM {{.. == 3}}
