module ProfileHelper

  def display_field(title, profile, field, force = false)
    if (!force && !profile.active_fields.include?(field.to_s)) ||
       (profile.active_fields.include?(field.to_s) && !profile.public_fields.include?(field.to_s) && (!user || (user != profile && !user.is_a_friend?(profile))))
      return ''
    end
    value = profile.send(field)
    if !value.blank?
      if block_given?
        value = yield(value)
      end
      content_tag('tr', content_tag('td', title, :class => 'field-name') + content_tag('td', value))
    else
      ''
    end
  end

  def display_contact(profile)	
    city = display_field(_('City:'), profile, :city)
    state = display_field(_('State:'), profile, :state)
    country = display_field(_('Country'), profile, :country) 
    nationality = display_field(_('Nationality'), profile, :nationality)
    address = display_field(_('Address:'), profile, :address)
    zip = display_field(_('ZIP code:'), profile, :zip_code)
    address_reference = display_field(_('Address Reference:'), profile, :address_reference)
    phone = display_field(_('Contact phone:'), profile, :contact_phone)
    cell = display_field(_('Cell Phone:'), profile, :cell_phone)
    comercial = display_field(_('Comercial Phone:'), profile, :comercial_phone) 
    email = display_field(_('e-Mail:'), profile, :email) { |email| link_to_email(email) }
    contact_info = display_field(_('Contact Information:'), profile, :contact_information)

    if city.blank? && state.blank? && country.blank? && nationality.blank? && address.blank? && zip.blank? && address_reference.blank? && phone.blank? && cell.blank? && comercial.blank? && email.blank? && contact_info.blank?
      ''
    else
      content_tag('tr', content_tag('th', _('Contact'), { :colspan => 2 })) + city + state + country + nationality + address + zip + address_reference + phone + cell + comercial + email + contact_info 
    end
  end

  def display_education_info(profile)
    lattes = display_field(_('Lattes:'), profile, :lattes) { |lattes| link_to 'Lattes', lattes, :target => 'blank' }
    fields_of_interest = display_field(_('Fields of Interest:'), profile, :fields_of_interest)
    schooling = display_field(_('Schooling:'), profile, :schooling)
    formation = display_field(_('Formation:'), profile, :formation)
    area_of_study = display_field(_('Area of study:'), profile, :custom_area_of_study)

    if area_of_study.blank?
      area_of_study = display_field(_('Area of study:'), profile, :area_of_study)    
    end

    if lattes.blank? && fields_of_interest.blank? && schooling.blank? &&
      area_of_study.blank? && formation.blank?
      ''
    else
      content_tag('tr', content_tag('th', _('Education'), { :colspan => 2 })) + schooling + formation + area_of_study + fields_of_interest + lattes
    end
  end

  def display_work_info(profile)
  	professional_activity = display_field(_('Professional Activity'), profile, :professional_activity)
    organization = display_field(_('Organization:'), profile, :organization)
    organization_site = display_field(_('Organization Website:'), profile, :organization_website) { |url| link_to url, url, :target => 'blank'}
    
    if professional_activity.blank? && organization.blank? && organization_site.blank?
      ''
    else
      content_tag('tr', content_tag('th', _('Work'), { :colspan => 2 })) + professional_activity + organization + organization_site
    end
  end

end
