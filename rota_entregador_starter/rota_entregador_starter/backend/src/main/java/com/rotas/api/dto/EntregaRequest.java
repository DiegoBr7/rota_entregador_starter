package com.rotas.api.dto;
import jakarta.validation.constraints.*;
public record EntregaRequest(@NotBlank String destinatario,@NotBlank String endereco,@NotNull @DecimalMin("-90") @DecimalMax("90") Double latitude,@NotNull @DecimalMin("-180") @DecimalMax("180") Double longitude) {}
