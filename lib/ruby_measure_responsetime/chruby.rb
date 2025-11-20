# frozen_string_literal: true

# Logic to use Chruby
class Chruby
  CHRUBY_PATHS = [
    '/opt/dev/sh/chruby/chruby.sh',
    '/usr/local/share/chruby/chruby.sh',
    '/usr/share/chruby/chruby.sh',
    '$HOME/.chruby/chruby.sh'
  ].freeze

  def self.ruby_manager
    self
  end

  def self.installed_rubies
    [
      ["ruby-3.4.7", nil],
      ["ruby-4.0.0", nil],
    ]
  end

  def self.cmd_initialize_ruby_version_manager
    source_chruby_cmd
  end

  def self.cmd_switch_to_ruby(version)
    # Clear bundler environment variables that interfere with chruby
    # Unlike RVM/rbenv which use shims, chruby modifies PATH and GEM_* variables directly,
    # so bundler's environment from the parent process can interfere with the ruby switch
    "unset BUNDLE_GEMFILE BUNDLE_BIN_PATH RUBYOPT BUNDLER_VERSION BUNDLE_PATH GEM_HOME GEM_PATH BUNDLE_APP_CONFIG; chruby #{version} > /dev/null;"
  end

  def self.source_chruby_cmd
    CHRUBY_PATHS.map { |path| "source #{path} 2>/dev/null" }.join(' || ') + ';'
  end

  def self.ruby_manager_installed?
    true
  end
end
