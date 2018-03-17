module Crud
  private

  def destroy_model(model)
    model.destroy
    render json: { message: I18n.t('flash.destroy') },
           status: :ok
  end

  def list_model(model_class)
    list = model_class.page(params[:page])
    render json: list, meta: pagination_dict(list), adapter: :json
  end

  def pagination_dict(object)
    {
      currentPage: object.current_page,
      totalItems: object.total_count,
      itemsPerPage: 25
    }
  end

  def save_model(model)
    if model.save
      render json: { reg: model, message: I18n.t('flash.create') },
             status: :created
    else
      render json: model.errors,
             status: :unprocessable_entity
    end
  end

  def update_model(model, model_params)
    if model.update(model_params)
      render json: { reg: model, message: I18n.t('flash.update') },
             status: :ok
    else
      render json: model.errors,
             status: :unprocessable_entity
    end
  end

  def render_user(user, msg)
    if user.errors.empty?
      render status: :ok, json: {
        message: I18n.t("#{msg}.message"),
        title: I18n.t("#{msg}.title")
      }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
