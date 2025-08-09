// Sistema de colizão horizontal

// Derivar direção horizontal real do movimento
var dir_h_real = sign(lengthdir_x(1, move_dir)); // -1, 0, 1 baseado em move_dir


// Limite de velocidade, se necessário
//velh = clamp(velh, -max_velh, max_velh);

// Sistema de colisão horizontal com refinamento
// Sistema de colisão horizontal com refinamento
var _steps = floor(abs(velh));
var _velh = sign(velh);
var _collision_detected = false;

repeat(_steps)
{
    if (place_meeting(x + _velh, y, obj_block))
    {
        _collision_detected = true;
        break;
    }
    else
    {
        x += _velh;
    }
}

if (_collision_detected)
{
    // Lógica para lidar com a colisão
    velh = 0;
}




// Sistema de colizão e movimentação vertical

// Sistema de colisão vertical
var _steps = floor(abs(velv));
var _velv = sign(velv);
var altura_cabeca = 6;

repeat(_steps)
{
    // DETECÇÃO DE CABEÇA ANTES DA MÁSCARA
    if (_velv < 0 && collision_point(x, y - altura_cabeca, obj_block, false, true))
    {
        velv = 0;
        break;
    }

    if (place_meeting(x, y + _velv, obj_block))
    {
        while (!place_meeting(x, y + sign(_velv), obj_block))
        {
            y += sign(_velv);
        }
        velv = 0;
        break;
    }
    else
    {
        y += _velv;
    }
}

usa_arma();