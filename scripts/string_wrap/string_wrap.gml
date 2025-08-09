/// @function string_wrap(text, max_width)
/// @param text {string}
/// @param max_width {real}
/// @returns {array} Linhas quebradas automaticamente respeitando limite de largura

var text = argument0;
var max_width = argument1;

var lines_raw = string_split(text, "\n"); // suporte a quebras manuais
var final_lines = [];

for (var l = 0; l < array_length(lines_raw); l++) {
    var line = lines_raw[l];
    var words = string_split(line, " ");
    var current = "";

    for (var i = 0; i < array_length(words); i++) {
        var test = current == "" ? words[i] : current + " " + words[i];
        if (string_width(test) <= max_width) {
            current = test;
        } else {
            array_push(final_lines, current);
            current = words[i];
        }
    }
    if (current != "") array_push(final_lines, current);
}

return final_lines;