module URI

    # Own implementation of decode_www_form.
    # Shall behave almost like the original method, but without any encoding
    # stuff.
    #
    # @param [String] query The query string
    # @param [String] _encoding Unused, only for compatibility
    # @return [Array] Parsed query
    #
    def self.decode_www_form(query, _encoding = nil)
      return [] if query.empty?

      unless query.match /^[^#=;&]*=[^#=;&]*([;&][^#=;&]*=[^#=;&]*)*$/
        raise ArgumentError,
          "invalid data of application/x-www-form-urlencoded (#{query})"
      end
      parsed = []
      # breakes the string at & and ;
      query.split(/[&;]/).each do |query_part|
        # breakes the string parts at =
        key, value = query_part.split('=')

        # make an empty string out of value, if it's nil
        value = '' if value.nil?
        # append the key value pair on the result array
        parsed << [
          decode_www_form_component(key),
          decode_www_form_component(value)
        ]
      end
      # return result array
      return parsed
    end

    TBLDECWWWCOMP_ = {}

    # Own implementation of decode_www_form_component.
    # Shall behave almost like the original method, but without any encoding
    # stuff.
    #
    # @param [String] string
    # @param [String] _encoding Unused, only for compatibility
    # @return [String]
    #
    def self.decode_www_form_component(string, _encoding = nil) 
      # Fill table for URI special chars
      if TBLDECWWWCOMP_.empty?
        tbl = {}
        256.times do |i|
          h, l = i>>4, i&15
          tbl['%%%X%X' % [h, l]] = i.chr
          tbl['%%%x%X' % [h, l]] = i.chr
          tbl['%%%X%x' % [h, l]] = i.chr
          tbl['%%%x%x' % [h, l]] = i.chr
        end
        tbl['+'] = ' '
        begin
          TBLDECWWWCOMP_.replace(tbl)
          TBLDECWWWCOMP_.freeze
        rescue
        end
      end
      # unless /\A[^%]*(?:%\h\h[^%]*)*\z/ =~ str
      #   raise ArgumentError, "invalid %-encoding (#{str})"
      # end

      # Replace URI special chars
      string.gsub(/\+|%[a-zA-Z0-9]{2}/) do |sub_string|
        TBLDECWWWCOMP_[sub_string]
      end
    end

end
