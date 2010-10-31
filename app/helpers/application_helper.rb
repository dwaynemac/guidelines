# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def success_widget(message)
    return if message.nil?
    message_widget(:icon => 'check', :state => 'highlight', :label => 'OK', :message => message)
  end

  def notice_widget(message)
    return if message.nil?
    message_widget(:icon => 'info', :state => 'highlight', :label => 'Hey!', :message => message)
  end


  def alert_widget(message)
    return if message.nil?
    message_widget(:icon => 'alert', :state => 'alert', :label => 'Alert', :message => message)
  end

  def message_widget(opts)
<<-AW
<div class="ui-widget">
  <div class="ui-state-#{opts[:state]} ui-corner-all" style="padding: 0 .7em;">
    <p><span class="ui-icon ui-icon-#{opts[:icon]}" style="float: left; margin-right: .3em;"></span>
    <strong>Alert:</strong> #{opts[:message]}.</p>
  </div>
</div>
AW
  end

  # Render jeditable in place edit field.
  # TODO: h for safety
  # TODO: select include_blank
  #
  # == Valid Options:
  # - object: defaults to @object_name
  # - type: default to text. If 'select' then select_collection is required.
  # - select_collection: json array of options for select dropdown.
  # - select_loadurl: url to get json for collection. overrides select_collection
  # - rows: jeditable rows defaults to 1
  # - print: this will be called on object and printed. defaults to field_name. Example: category.name will call object.category.name
  # - url: URL for request
  # - style: jeditable style
  #
  # Will submit to url_for(object)
  # While data transfer is in progress CSS class 'editing' is assigned.
  #
  # In controller response should be
  #   <tt>format.json { render :json => jeditable_result(@transaction, true) }</tt> for success.
  #   <tt>format.json { render :json => jeditable_result(@transaction, false) }</tt> for failure.
  #
  def jeditable_field(object_name, field_name, options = {})

    options.reverse_merge!({:type => 'text', :rows => '1'})

    object = options[:object] || self.instance_variable_get("@#{object_name}")

    if options[:print].blank?
      field = object.send(field_name)
      wants = field_name
    else
      tokens = options[:print].split('.')
      field = object
      tokens.each do |t|
        field = field.send(t) unless field.nil?
      end
      wants = options[:print]
    end

    case options[:type].to_s
      when 'select'
        submit = %(
        submit   : '#{t('jeditable.submit')}',
        cancel   : '#{t('jeditable.cancel')}',
        onblur   : function() {
            $(this).removeClass('editing');
          },
        )
      when 'text'
        submit = %(
        onblur   : function() {
            this.reset();
            $(this).removeClass('editing');
          },
        )
      when 'datepicker'
        submit = %(
        onblur   : function() {
            this.reset();
            $(this).removeClass('editing');
          },
        )
    end

    output = content_tag(:span, field, {:id => "jeditable_#{dom_id object}_#{field_name}", :class => "jeditable"})
    output << javascript_tag do %(
      $(document).ready(function() {
        $('#jeditable_#{dom_id object}_#{field_name}').editable(
          function(value, settings) {
            var result;
            $.ajax({
              type: 'PUT',
              url: '#{options[:url] || url_for(object)}' ,
              async: false,
              data: {
                authenticity_token: #{form_authenticity_token.to_json },
                wants: '#{wants}',
                '#{object_name}[#{field_name}]' : value
              },
              dataType: 'json',
              success: function(data) {
                result = data.result;
              }
            });
            return(result);
          }, {
          #{(options[:loadurl].nil?? "data: '#{options[:select_collection]}'," : "loadurl: '#{options[:loadurl]}',") if options[:type].to_s=='select'}
          type    : '#{options[:type]}',
          #{"rows   : '#{options[:rows]}'," if options[:type].to_s == 'text'}
          tooltip   : ' #{t('jeditable.tooltip')}',
          placeholder: '#{t('jeditable.tooltip')}',
          style     : #{options[:style] || "'display: inline;'"},
          #{submit}
          onedit    : function() {
            $(this).addClass('editing');
          }
        });
      });
      )
    end
    output
  end
end
