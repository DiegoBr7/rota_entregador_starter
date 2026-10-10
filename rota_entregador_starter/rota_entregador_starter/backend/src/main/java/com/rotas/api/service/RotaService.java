package com.rotas.api.service;
import com.rotas.api.model.Entrega;
import com.rotas.api.repository.EntregaRepository;
import org.springframework.stereotype.Service;
import java.util.*;
@Service public class RotaService {
 private final EntregaRepository repo;
 public RotaService(EntregaRepository repo){this.repo=repo;}
 public List<Entrega> ordenar(double lat,double lon){
  List<Entrega> restantes=new ArrayList<>(repo.findAll().stream().filter(e->e.status==Entrega.Status.PENDENTE).toList());
  List<Entrega> ordenadas=new ArrayList<>();
  while(!restantes.isEmpty()){
   double atualLat=lat,atualLon=lon;
   Entrega proxima=restantes.stream().min(Comparator.comparingDouble(e->distancia(atualLat,atualLon,e.latitude,e.longitude))).orElseThrow();
   ordenadas.add(proxima);restantes.remove(proxima);lat=proxima.latitude;lon=proxima.longitude;
  }
  return ordenadas;
 }
 private double distancia(double a,double b,double c,double d){
  double r=6371,dl=Math.toRadians(c-a),dn=Math.toRadians(d-b);
  double h=Math.pow(Math.sin(dl/2),2)+Math.cos(Math.toRadians(a))*Math.cos(Math.toRadians(c))*Math.pow(Math.sin(dn/2),2);
  return 2*r*Math.asin(Math.min(1,Math.sqrt(h)));
 }
}
