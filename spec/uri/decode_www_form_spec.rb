# encoding: UTF-8

require 'spec_helper'

describe URI, '#decode_www_form' do

  it 'seperates parameter into an array' do
    result = URI::decode_www_form("foo=bar&bar=foo")

    result.should eq([['foo', 'bar'], ['bar', 'foo']])
  end

  it 'can handle more than two equal parameter names' do
    result = URI::decode_www_form("foo=bar1&foo=bar2")

    result.should eq([['foo', 'bar1'], ['foo', 'bar2']])
  end

  it 'can handle whitespaces in query string' do
    result = URI::decode_www_form("foo=bar&bar=bar%20foo")

    result.should eq([['foo', 'bar'], ['bar', 'bar foo']])
  end

  it 'accepts semi-colons as seperators' do
    result = URI::decode_www_form("foo=bar;bar=foo")

    result.should eq([['foo', 'bar'], ['bar', 'foo']])
  end

  it 'seperates & and ; mixed queries properly' do
    result = URI::decode_www_form("foo=bar&bar=foo;baz=foo")

    result.should eq([['foo', 'bar'], ['bar', 'foo'], ['baz', 'foo']])
  end

  it 'does not accept only a normal string as query string' do
    expect{
      result = URI::decode_www_form("foo")

      # does not work, probably should?
      #result.should eq([['foo', '']])
    }.to raise_error(
      ArgumentError,
      "invalid data of application/x-www-form-urlencoded (foo)"
    )
  end

  it 'accepts empty values' do
      result = URI::decode_www_form("foo=bar&bar=&baz=foo")

      result.should eq([['foo', 'bar'], ['bar', ''], ['baz', 'foo']])
  end

  it 'understands plus as whitespace' do
    result = URI::decode_www_form("foo=bar&bar=bar+foo")

    result.should eq([['foo', 'bar'], ['bar', 'bar foo']])
  end

  it 'does not accept whitespaces in query string' do
    result = URI::decode_www_form("foo=bar&bar=bar foo&baz=foo")

    # Works, it probably shouldn't?
    result.should eq([['foo', 'bar'], ['bar', 'bar foo'], ['baz', 'foo']])
  end

  it 'can handle non ascii letters in query string' do
    result = URI::decode_www_form("foo=bär&bar=föö")

    # Works, but it maybe shouldn't?
    result.should eq([['foo', 'bär'], ['bar', 'föö']])
  end

  it 'can handle escaped non ascii letters in query string' do
    result = URI::decode_www_form("foo=b%C3%A4r&bar=f%C3%B6%C3%B6")

    result.should eq([['foo', 'bär'], ['bar', 'föö']])
  end

  it 'accepts - in query string' do
    result = URI::decode_www_form("foo-bar=bar&bar=foo-bar")

    result.should eq([['foo-bar', 'bar'], ['bar', 'foo-bar']])
  end

  it 'accepts . in query string' do
    result = URI::decode_www_form("foo.bar=bar&bar=foo.bar")

    result.should eq([['foo.bar', 'bar'], ['bar', 'foo.bar']])
  end

  it 'accepts ~ in query string' do
    result = URI::decode_www_form("foo~bar=bar&bar=foo~bar")

    result.should eq([['foo~bar', 'bar'], ['bar', 'foo~bar']])
  end

  it 'accepts _ in query string' do
    result = URI::decode_www_form("foo_bar=bar&bar=foo_bar")

    result.should eq([['foo_bar', 'bar'], ['bar', 'foo_bar']])
  end

  it 'handles [ ] in query string' do
    result = URI::decode_www_form("foo[]=foo&foo[]=bar")

    result.should eq([['foo[]', 'foo'], ['foo[]', 'bar']])
  end

  it 'returns an empty array, if query string is empty' do
    result = URI::decode_www_form("")

    result.should eq([])
  end

  it 'throws an error, if more than one = without an & or ; in between' do
    expect {
      result = URI::decode_www_form("foo=bar=foo&bar=foo=bar")
    }.to raise_error(
      ArgumentError,
      "invalid data of application/x-www-form-urlencoded "+
       "(foo=bar=foo&bar=foo=bar)"
    )
  end

  it 'throws an error, if more than one & without an = in between' do
    expect {
      result = URI::decode_www_form("foo&bar=foo&bar")
    }.to raise_error(
      ArgumentError,
      "invalid data of application/x-www-form-urlencoded (foo&bar=foo&bar)"
    )
  end

  it 'throws an error, if more than one ; without an = in between' do
    expect {
      result = URI::decode_www_form("foo;bar=foo;bar")
    }.to raise_error(
      ArgumentError,
      "invalid data of application/x-www-form-urlencoded (foo;bar=foo;bar)"
    )
  end

end
