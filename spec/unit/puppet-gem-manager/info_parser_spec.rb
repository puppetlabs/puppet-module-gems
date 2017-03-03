require 'spec_helper'

describe PuppetGemManager::InfoParser do
  describe "#get_info" do

    it "should import data from info file" do
      info_hash = {
        'info' => {
          'prefix'   => 'foo',
          'authors'  => 'foo-author',
          'email'    => 'foo@fooinc.com',
          'homepage' => 'http://foo.com',
          'licenses' => 'foobar',
          'summary'  => 'A foo for all foos',
          'version'  => '0.0.0',
        }
      }

      allow(YAML).to receive(:load_file).with("/tmp/foofile").and_return(info_hash)
      result = PuppetGemManager::InfoParser.get_info("/tmp/foofile")
      expect(result).to eq(info_hash['info'])
    end

    describe 'should validate input file' do

      it 'is not empty' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return(false)
        expect { PuppetGemManager::InfoParser.get_info('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [InfoParser] Failed to read Information configuration file.')
      end

      it 'starts with correct key' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return({'foo' => 'bar'})
        expect { PuppetGemManager::InfoParser.get_info('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [InfoParser] Info configuration is invalid. Missing top-level \'info\' key.')
      end

      it 'has content' do
        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return({'info' => nil})
        expect { PuppetGemManager::InfoParser.get_info('/tmp/foofile') }.
          to raise_error(SystemExit, 'FAILED: [InfoParser] Info configuration file contains no information.')
      end

      it 'has required fields' do
        missing_key = 'licenses'
        info_hash = {
          'info' => {
            'prefix'   => 'foo',
            'authors'  => 'foo-author',
            'email'    => 'foo@fooinc.com',
            'homepage' => 'http://foo.com',
            'licenses' => 'foobar',
            'summary'  => 'A foo for all foos',
            'version'  => '0.0.0',
          }
        }
        info_hash['info'].delete missing_key

        allow(YAML).to receive(:load_file).with('/tmp/foofile').and_return(info_hash)
        expect { PuppetGemManager::InfoParser.get_info('/tmp/foofile') }.
          to raise_error(SystemExit, "FAILED: [InfoParser] Info Configuration is missing required key of #{missing_key}.")
      end

    end
  end
end
