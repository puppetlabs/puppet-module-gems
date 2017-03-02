require 'spec_helper'

describe PuppetGemManager::DependenciesParser do
  describe '#build_gem_matrix' do

    it 'should import data from dependencies file' do
      dep_hash = {
        'dependencies' => {
          'shared' => 
            {'b0' => [{'gem' => 'c0', 'version' => '> 0.0.1'}],
             'b1' => [{'gem' => 'c1', 'version' => '< 1.0.0'}]},
          'a0' =>
            {'b1' => [{'gem' => 'c2'}]},
          'a1' =>
            {'b0' => [{'gem' => 'c3'}]},
        }
      }

      allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return(dep_hash)
      result = PuppetGemManager::DependenciesParser.build_gem_matrix('/tmp/foofile')

      expect(result.keys.length).to eq(4)      

      # Validate that the matrix is built with correct keys
      ['a0-b0', 'a0-b1', 'a1-b0', 'a1-b1'].each do |key|
        expect(result.keys).to include(key)
      end

      # Validate that the matrix is built with correct shared deps
      ['a0-b0', 'a1-b0'].each do |key|
        expect(result[key]).to     include({'gem' => 'c0', 'version' => '> 0.0.1'})
        expect(result[key]).not_to include({'gem' => 'c1', 'version' => '< 1.0.0'})
      end

      ['a0-b1', 'a1-b1'].each do |key|
        expect(result[key]).to     include({'gem' => 'c1', 'version' => '< 1.0.0'})
        expect(result[key]).not_to include({'gem' => 'c0', 'version' => '> 0.0.1'})
      end

      # Validate that the matrix has specific deps
      expect(result['a0-b0']).not_to include({'gem' => 'c2'})
      expect(result['a0-b1']).to     include({'gem' => 'c2'})
      expect(result['a1-b0']).to     include({'gem' => 'c3'})
      expect(result['a1-b1']).not_to include({'gem' => 'c3'})
    end

    describe 'should validate input file' do

      it 'is not empty' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return(false)
        expect { PuppetGemManager::DependenciesParser.build_gem_matrix('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [DependenciesParser] Failed to read Dependencies configuration file.')
      end

      it 'starts with correct key' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return({'foo' => 'bar'})
        expect { PuppetGemManager::DependenciesParser.build_gem_matrix('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [DependenciesParser] Dependencies configuration is invalid. Missing top-level \'dependencies\' key.')
      end

      it 'has content' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return({'dependencies' => nil})
        expect { PuppetGemManager::DependenciesParser.build_gem_matrix('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [DependenciesParser] Dependencies configuration contains no dependencies.')
      end

    end
  end
end
