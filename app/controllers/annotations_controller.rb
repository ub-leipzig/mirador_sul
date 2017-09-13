##
# Controller that handles Annotation CRUD
class AnnotationsController < ApplicationController
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  load_and_authorize_resource

  def show; end

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

  # DELETE /annotation/:id
  def destroy
    @annotation.user = current_user
    @annotation.destroy
    render status: :accepted, body: t('annotations.destroy')
  end

  # PATCH /annotation/:id
  def update
    @annotation.user = current_user
    @annotation.update
    render status: :accepted, body: t('annotations.update')
  end

  private

  def annotation_params
    params.require(:annotation).permit(:uuid, :data, :canvas)
  end

  def annotation_search_params
    params.require(:uri)
  end
end
