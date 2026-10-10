package com.rotas.api.model;
import jakarta.persistence.*;
@Entity public class Entrega {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) public Long id;
 @Column(nullable=false) public String destinatario;
 @Column(nullable=false) public String endereco;
 @Column(nullable=false) public Double latitude;
 @Column(nullable=false) public Double longitude;
 @Enumerated(EnumType.STRING) @Column(nullable=false) public Status status=Status.PENDENTE;
 public enum Status {PENDENTE, CONCLUIDA, INSUCESSO}
}
