class Api::V1::OrganizationsController < ApplicationController
  include Paginable
  before_action :set_api_v1_organization, only: %i[show update destroy]

  # GET /api/v1/organizations
  def index
    render json: serialize_organizations, status: :ok
  end

  # GET /api/v1/organizations/1
  def show
    render json: serialize_organization
  end

  # POST /api/v1/organizations
  def create
    @api_v1_organization = Organization.new(api_v1_organization_params)

    if @api_v1_organization.save
      render json: serialize_organization, status: :created
    else
      render json: @api_v1_organization.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/organizations/1
  def update
    if @api_v1_organization.update(api_v1_organization_params)
      render json: serialize_organization, status: :ok
    else
      render json: @api_v1_organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/organizations/1
  def destroy
    @api_v1_organization.discard
  end

  private

  def serialize_organization
    OrganizationSerializer.new(@api_v1_organization).serializable_hash.to_json
  end

  def serialize_organizations
    @api_v1_organizations = Organization.kept.page(current_page).per(per_page)
    options = get_links_serializer_options('api_v1_organizations_path', @api_v1_organizations)
    OrganizationsSerializer.new(@api_v1_organizations, options).serializable_hash.to_json
  end

  def set_api_v1_organization
    @api_v1_organization = Organization.kept.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "There is no organization record with ID <#{params[:id]}>" }
  end

  def api_v1_organization_params
    params.permit(:name, :address, :phone, :email, :welcome_text, :about_us_text, :image_url)
  end
end
