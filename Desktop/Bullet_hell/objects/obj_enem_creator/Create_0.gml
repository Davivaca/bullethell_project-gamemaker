var quantidade = 10;

var xmin = 100;
var xmax = 1000;
var ymin = 100;
var ymax = 600;

var largura = sprite_get_width(obj_amora_calops.sprite_index);
var altura  = sprite_get_height(obj_amora_calops.sprite_index);


for (var i = 0; i < quantidade; i++) {
    var tentativas = 0;
    var max_tentativas = 100;

    repeat (max_tentativas) {
        var x_spawn = random_range(xmin, xmax);
        var y_spawn = random_range(ymin, ymax);
        
        // Define a área do inimigo, centralizada
        var esquerda = x_spawn - largura / 2;
        var direita  = x_spawn + largura / 2;
        var topo     = y_spawn - altura / 2;
        var fundo    = y_spawn + altura / 2;

        if (!collision_rectangle(esquerda, topo, direita, fundo, obj_block, false, true)) {
            instance_create_layer(x_spawn, y_spawn, "Instances", obj_amora_calops);
            break; // Sai do repeat se conseguir spawnar com sucesso
        }

        tentativas++;
        if (tentativas >= max_tentativas) break; // Impede travamentos
    }
}
