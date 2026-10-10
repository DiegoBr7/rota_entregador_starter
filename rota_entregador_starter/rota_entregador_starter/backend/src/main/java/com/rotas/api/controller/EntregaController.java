package com.rotas.api.controller;
import com.rotas.api.dto.*;
import com.rotas.api.model.Entrega;
import com.rotas.api.repository.EntregaRepository;
import com.rotas.api.service.RotaService;
import jakarta.validation.Valid;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import java.util.List;
@RestController @RequestMapping("/api") public class EntregaController {
 private final EntregaRepository repo; private final RotaService rotas;
 public EntregaController(EntregaRepository repo,RotaService rotas){this.repo=repo;this.rotas=rotas;}
 @GetMapping("/entregas") public List<Entrega> listar(){return repo.findAll();}
 @PostMapping("/entregas") @ResponseStatus(HttpStatus.CREATED) public Entrega criar(@Valid @RequestBody EntregaRequest r){
  Entrega e=new Entrega();e.destinatario=r.destinatario();e.endereco=r.endereco();e.latitude=r.latitude();e.longitude=r.longitude();return repo.save(e);
 }
 @PatchMapping("/entregas/{id}/status") public Entrega status(@PathVariable Long id,@RequestParam Entrega.Status valor){
  Entrega e=repo.findById(id).orElseThrow(()->new ResponseStatusException(HttpStatus.NOT_FOUND,"Entrega não encontrada"));e.status=valor;return repo.save(e);
 }
 @PostMapping("/rotas/otimizar") public List<Entrega> otimizar(@Valid @RequestBody RotaRequest r){return rotas.ordenar(r.latitude(),r.longitude());}
}
