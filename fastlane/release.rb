platform :ios do
  lane :release do
    release_appstore
    release_adhoc
  end

  private_lane :release_appstore do
    build_ios_app(
      workspace: 'ThatDistribution.xcworkspace',
      scheme: 'ThatApp',
      archive_path: './build/ThatApp.xcarchive',
      output_directory: './build',
      clean: true
    )
    upload_to_app_store(
      team_id: '<apple developer team id>',
      ipa: lane_context[SharedValues::IPA_OUTPUT_PATH],
      run_precheck_before_submit: false
    )
  end
  
  private_lane :release_adhoc do
      flavor_adhoc_ipa
      resign_adhoc_ipa
      # upload command depends on the distribution channel
  end
    
  private_lane :flavor_adhoc_ipa do
      sh("./FlavorAdHoc.sh 'ThatApp' ./build")
  end
    
  private_lane :resign_adhoc_ipa do
      # Download adhoc app profile
      sigh(
        adhoc: true,
        force: true,
        skip_install: true,
        skip_certificate_verification: true,
        app_identifier: 'that.app.adhoc',
        output_path: './build',
        filename: 'ThatAppAdHoc.mobileprovision'
      )
      # Download adhoc extension app profile
      sigh(
        adhoc: true,
        force: true,
        skip_install: true,
        skip_certificate_verification: true,
        app_identifier: 'that.app.adhoc.nse',
        output_path: './build',
        filename: 'ThatAppExtensiondHoc.mobileprovision'
      )
      resign(
        ipa: './build/AdHocApp.ipa',
        bundle_id: 'that.app.adhoc',
        signing_identity: '<Copy the full name of distribution certificate as appears in the Keychain Access>',
        provisioning_profile: {
             'that.app.adhoc' => './build/ExtensionAdHoc.mobileprovision',
             'that.app.adhoc.nse' => './build/ThatAppExtensiondHoc.mobileprovision',
        }
      )
  end
end
