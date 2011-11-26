class Lexer
  class Token
    attr_accessor :file, :line, :position, :length
    def initialize(params)
      @file = params[:file]
      @line = params[:line]
      @position = params[:position]
      @length = params[:length]
      @type = params[:type]
      @src = params[:src]
    end
    
    def to_s
      return @type + "[#{@src.to_json},#{@line}:#{@position},#{@length}]"
    end
  end
  
  attr_accessor :tokens
  
  def initialize(file, src)
    # Standardize line endings
    @file = file
    @src = src.gsub("\r\n","\n").gsub("\r","\n")
    @tokens = lexify!
    @current_token = 0
  end
  
  def lexify!
    pos = 0
    tokens = []
    @line_ctr = 0
    while true
      token, pos = lex(pos)
      break if token.nil?
      tokens << token
    end
    return tokens
  end
  
  def lex(spos)
    spos = skip_whitespace(spos)
    return nil if spos >= @src.length

    if (@src[spos] >= 'a' && @src[spos] <= 'z') ||
        (@src[spos] >= 'A' && @src[spos] <= 'Z') ||
        (@src[spos] == '_' || @src[spos].ord > 127)
      return lex_identifier(spos)
    elsif @src[spos] >= '0' && @src[spos] <= '9'
      return lex_numeric(spos)
    elsif @src[spos] == "\n"
      return [Token.new(
        :file => @file, 
        :line => @line_ctr, 
        :position => spos, 
        :length => 1,
        :type => "EOL",
        :src => "\n"
      ), spos + 1]
    else
      return [Token.new(
        :file => @file, 
        :line => @line_ctr, 
        :position => spos, 
        :length => 1,
        :type => "OP",
        :src => @src[spos,1]
      ), spos + 1]
    end
  end

  def skip_whitespace(spos)
    while spos < @src.length && (@src[spos] == "\t" || @src[spos] == " ")
      spos += 1
    end
    return spos
  end

  def lex_identifier(spos)
    endPos = spos
    while endPos < @src.length && (
      (@src[endPos] >= 'a' && @src[endPos] <= 'z') ||
      (@src[endPos] >= 'A' && @src[endPos] <= 'Z') ||
      (@src[endPos] >= '0' && @src[endPos] <= '9') ||
      (@src[endPos] == '_' || @src[endPos] == '-' || @src[spos].ord > 127))
      endPos += 1
    end
    
    return [Token.new(
      :file => @file, 
      :line => @line_ctr, 
      :position => spos, 
      :length => endPos - spos, 
      :type => "IDENTIFIER",
      :src => @src[spos, endPos - spos]
    ), endPos]
  end

  def lex_numeric(spos)
    # First, integer digits
    endPos = spos
    while endPos < @src.length && (
      (@src[endPos] >= '0' && @src[endPos] <= '9'))
      endPos += 1
    end
    
    # Optionally, a decimal portion, which requires a period and at least one digit
    if endPos + 1 < @src.length && @src[endPos] == '.' && (@src[endPos + 1] >= '0' && @src[endPos + 1] <= '9')
      endPos += 1
      while endPos < @src.length && (
        (@src[endPos] >= '0' && @src[endPos] <= '9'))
        endPos += 1
      end
    end
    
    return [Token.new(
      :file => @file, 
      :line => @line_ctr, 
      :position => spos, 
      :length => endPos - spos, 
      :type => "NUMERIC",
      :src => @src[spos, endPos - spos]
    ), endPos]
  end
end
