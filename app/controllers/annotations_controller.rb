##
# Controller that handles Annotation CRUD
class AnnotationsController < ApplicationController
  protect_from_forgery with: :null_session
  #before_action :authenticate_user!
  before_action :set_annotation, only: [:show, :update, :destroy]
  load_and_authorize_resource

  def show;
  end

  # GET /annotations
  def index
    @annotations = Annotation.accessible_by(current_ability).where(canvas: annotation_search_params)
  end

  # POST /annotations
  def create
    @annotation = Annotation.new(annotation_params)
    @annotation.user = current_user
    if @annotation.save
      render json: @annotation.data
    else
      render status: :bad_request, body: t('annotations.create_error')
    end
  end

  # DELETE /annotation/:uuid
  def destroy
    @annotation.destroy
  end

  # PATCH /annotation/:uuid
  def update
    respond_to do |format|
      if @annotation.update(annotation_params)
        format.json {render json: @annotation, status: :ok}
      else
        format.json {render json: {status: :error}, status: :bad_request}
      end
    end
  end

  private

  def set_annotation
    @annotation = Annotation.where('uuid = ?', params[:uuid]).first
  end

  def annotation_params
    params.require(:annotation).permit(:uuid, :data, :canvas)
  end

  def annotation_search_params
    params.require(:uri)
  end
end
