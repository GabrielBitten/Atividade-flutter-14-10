class Transacao {
  int? id;  
  String nome;  
  double valor;  

  Transacao({
    this.id,
    required this.nome,
    required this.valor
    });

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      nome: json['nome'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'valor': valor,
    };
  }
}
