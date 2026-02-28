cargas_d = lerp(cargas_d, cargas, 0.15);
    
if (abs(cargas_d - cargas) < 0.01) {
    cargas_d = cargas;
}

var _speed = max(0.05, cargas_inicial * 0.01);

cargas_g = approach(cargas_g, cargas, _speed);
cargas_g = clamp(cargas_g, 0, cargas_inicial);