<% with_modules(modules) do -%>
class <%= class_name %> < Application
  # provides :xml, :yaml, :js

  # GET /<%= resource_path %>
  def index
    @<%= plural_model %> = <%= model_class_name %>.all
    display @<%= plural_model %>
  end

  # GET /<%= resource_path %>/:id
  def show
    @<%= singular_model %> = <%= model_class_name %>.get(<%= params_for_get %>)
    raise NotFound unless @<%= singular_model %>
    display @<%= singular_model %>
  end

  # GET /<%= resource_path %>/new
  def new
    only_provides :html
    @<%= singular_model %> = <%= model_class_name %>.new
    render
  end

  # GET /<%= resource_path %>/:id/edit
  def edit
    only_provides :html
    @<%= singular_model %> = <%= model_class_name %>.get(<%= params_for_get %>)
    raise NotFound unless @<%= singular_model %>
    render
  end

  # POST /<%= resource_path %>
  def create
    @<%= singular_model %> = <%= model_class_name %>.new(params[:<%= singular_model %>])
    if @<%= singular_model %>.save
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>, @<%= singular_model %>)
    else
      render :new
    end
  end

  # PUT /<%= resource_path %>/:id
  def update
    @<%= singular_model %> = <%= model_class_name %>.get(<%= params_for_get %>)
    raise NotFound unless @<%= singular_model %>
    if @<%= singular_model %>.update_attributes(params[:<%= singular_model %>]) || !@<%= singular_model %>.dirty?
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>, @<%= singular_model %>)
    else
      raise BadRequest
    end
  end

  # DELETE /<%= resource_path %>/:id
  def destroy
    @<%= singular_model %> = <%= model_class_name %>.get(<%= params_for_get %>)
    raise NotFound unless @<%= singular_model %>
    if @<%= singular_model %>.destroy
      redirect url(:<%= (modules.collect{|m| m.downcase} << singular_model).join("_") %>)
    else
      raise BadRequest
    end
  end

end # <%= class_name %>
<% end -%>
