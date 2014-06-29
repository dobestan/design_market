module RequestsHelper
  def generate_request_title(request_id)
    request = Request.find(request_id)
    request.usage.to_s + " " + get_request_type_name(request.design_type) + " 디자인"
  end

  def get_request_type_name(type_id)
    Type.find(type_id).name.to_s
  end
end
