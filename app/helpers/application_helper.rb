module ApplicationHelper
	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

	def resource_class
		User
	end

  def javascript_variables(variables = nil)
    @javascript_variables ||= {}
    @javascript_variables.merge!(variables) and return if !variables.nil?

    output  = ''
    padding = @javascript_variables.keys.group_by(&:size).max.first

    @javascript_variables.each do |variable, value|
      output << "#{variable.to_s.ljust(padding)} = #{value.to_json},\n          "
    end

    raw "var " + output.strip.html_safe.gsub(/\,\Z/m, ';')
  end
end
