 module PesosHelper
  def situacao_imc(imc, icone=true)
    if imc <= 18.49
      (icone ? raw('<i class="fa fa-hand-o-down fa-lg"></i> ') : '') + 'Abaixo do peso'
    elsif imc > 18.49 and imc < 25
      (icone ? raw('<i class="fa fa-smile-o fa-lg"></i> ') : '') + 'Normal'
    elsif imc >= 25 and imc < 30
      (icone ? raw('<i class="fa fa-hand-o-up fa-lg"></i> ') : '') + 'Acima do peso'
    elsif imc >= 30
      (icone ? raw('<i class="fa fa-warning fa-lg"></i> ') : '') + 'Obesidade'
    end
  end
end