# frozen_string_literal: true

guard 'rack', port: '5000', cmd: 'reel-rack' do
  watch('Gemfile.lock')
  watch(%r{^(lib)/.*})
end

guard 'rack', port: '5001', server: 'Puma' do
  watch('Gemfile.lock')
  watch(%r{^(lib)/.*})
end
