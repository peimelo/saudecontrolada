 module PesosHelper
  def situacao_imc(imc, icone = true)
    if imc <= 18.49
      (icone ? raw('<i class="fa fa-hand-o-down fa-lg"></i> ') : '') + t('peso.imc.abaixo')
    elsif imc > 18.49 and imc < 25
      (icone ? raw('<i class="fa fa-smile-o fa-lg"></i> ') : '') + t('peso.imc.normal')
    elsif imc >= 25 and imc < 30
      (icone ? raw('<i class="fa fa-hand-o-up fa-lg"></i> ') : '') + t('peso.imc.acima')
    elsif imc >= 30
      (icone ? raw('<i class="fa fa-warning fa-lg"></i> ') : '') + t('peso.imc.obesidade')
    end
  end
 end
