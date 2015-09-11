require 'spec_helper'

describe 'GrapeDoc::MarkdownFormatter' do
  let(:formatter) { GrapeDoc::MarkdownFormatter.new }

  let(:resource) do
    instance_double('GrapeDoc::APIResource',
      resource_name: 'MightyNeatResource',
      documents: [document])
  end

  let(:param) do
    instance_double('GrapeDoc::APIParameter',
      field: 'radical_value[radical_nested]',
      field_type: 'String',
      required: true,
      description: 'This value is so very rad.  I bet you wish you were too.',
      sample_value: 'raddish')
  end

  let(:document) do
    instance_double('GrapeDoc::APIDocument',
      params: [param],
      http_method: 'POST',
      path: '/a_twisty_path',
      description: 'Nobody really knows what this does.'\
        'Nobody but Zorp that is.')
  end

  subject(:markdown) { formatter.generate_resource_doc(resource) }

  it 'escapes underscores in paths' do
    expect(markdown).not_to match /\/a_twisty_path/
    expect(markdown).to match /\/a\\_twisty\\_path/
  end

  it 'escapes underscores anb square bracket in param names' do
    expect(markdown).not_to match /radical_value\[radical_nested\]/
    expect(markdown).to match /radical\\_value\\\[radical\\_nested\\\]/
  end
end
