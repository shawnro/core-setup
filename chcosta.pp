<!--
============================================================================================================================================
E:\gh\shawnro\core-setup\build.proj
============================================================================================================================================
-->
<Project ToolsVersion="12.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <!--
============================================================================================================================================
  <Import Project="Directory.Build.props">

E:\gh\shawnro\core-setup\Directory.Build.props
============================================================================================================================================
-->
  <PropertyGroup xmlns="">
    <ImportNetSdkFromRepoToolset>false</ImportNetSdkFromRepoToolset>
  </PropertyGroup>
  <!--
============================================================================================================================================
  <Import Project="Sdk.props" Sdk="Microsoft.DotNet.Arcade.Sdk">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\Sdk\Sdk.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildThisFileFullPath);$(MSBuildAllProjects)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <!-- 
      When the bootstrapper script initializes a repo it restores an empty project that imports the toolset SDK.
      It invokes WriteToolsetLocation target with __ToolsetLocationOutputFile set to the path where the location of 
      SDK Build.proj entry point is to be stored. Suppress all other imports for that project.      
    -->
    <_SuppressSdkImports>false</_SuppressSdkImports>
    <_SuppressSdkImports Condition="'$(__ToolsetLocationOutputFile)' != ''">true</_SuppressSdkImports>
  </PropertyGroup>
  <!--
============================================================================================================================================
  <Import Project="..\tools\Settings.props" Condition="!$(_SuppressSdkImports)">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
    <ImportNetSdkFromRepoToolset Condition="'$(ImportNetSdkFromRepoToolset)' == ''">true</ImportNetSdkFromRepoToolset>
  </PropertyGroup>
  <!--
============================================================================================================================================
  <Import Project="BuildTasks.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\BuildTasks.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <ArcadeSdkBuildTasksAssembly Condition="'$(MSBuildRuntimeType)' != 'Core'">$(MSBuildThisFileDirectory)net461\Microsoft.DotNet.Arcade.Sdk.dll</ArcadeSdkBuildTasksAssembly>
    <ArcadeSdkBuildTasksAssembly Condition="'$(MSBuildRuntimeType)' == 'Core'">$(MSBuildThisFileDirectory)netcoreapp2.0\Microsoft.DotNet.Arcade.Sdk.dll</ArcadeSdkBuildTasksAssembly>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="ProjectLayout.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\ProjectLayout.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <!--
     Properties describing the layout of the repo specific to the current project.
  -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <!--
============================================================================================================================================
  <Import Project="RepoLayout.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\RepoLayout.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <!--
     Properties describing the layout of the repo.
  -->
  <!-- 
    Repositories are required to follow the following conventions:
      
    - global.json file in the repository root
      This file specifies the version of Arcade SDK like so:
      "msbuild-sdks": { "Microsoft.DotNet.Arcade.Sdk": "version" }
      
    - build/Versions.props 
      Specifies versions of dependencies
  -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <Configuration Condition="'$(Configuration)' == ''">Debug</Configuration>
    <Platform Condition="'$(Platform)' == ''">AnyCPU</Platform>
    <PlatformName Condition="'$(PlatformName)' == ''">$(Platform)</PlatformName>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <!-- Respect environment variable for the NuGet Packages Root if set; otherwise, use the current default location -->
    <NuGetPackageRoot Condition="'$(NuGetPackageRoot)' == ''">$(NUGET_PACKAGES)</NuGetPackageRoot>
    <NuGetPackageRoot Condition="'$(NuGetPackageRoot)' == '' AND '$(OS)' == 'Windows_NT'">$(UserProfile)\.nuget\packages\</NuGetPackageRoot>
    <NuGetPackageRoot Condition="'$(NuGetPackageRoot)' == '' AND '$(OS)' != 'Windows_NT'">$([System.Environment]::GetFolderPath(SpecialFolder.Personal))\.nuget\packages\</NuGetPackageRoot>
    <NuGetPackageRoot Condition="!HasTrailingSlash('$(NuGetPackageRoot)')">$(NuGetPackageRoot)\</NuGetPackageRoot>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <RepoRoot Condition="'$(RepoRoot)' == ''">$([MSBuild]::GetDirectoryNameOfFileAbove($(MSBuildProjectDirectory), 'global.json'))\</RepoRoot>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <!-- TODO: remove condition once all repos update their dir structure (https://github.com/dotnet/roslyn-tools/issues/177) -->
    <RepositoryEngineeringDir Condition="Exists('$(RepoRoot)eng')">$(RepoRoot)eng\</RepositoryEngineeringDir>
    <RepositoryEngineeringDir Condition="'$(RepositoryEngineeringDir)' == ''">$(RepoRoot)build\</RepositoryEngineeringDir>
    <VersionsPropsPath>$(RepositoryEngineeringDir)Versions.props</VersionsPropsPath>
    <ArtifactsDir Condition="'$(ArtifactsDir)' == ''">$(RepoRoot)artifacts\</ArtifactsDir>
    <ArtifactsToolsetDir>$(ArtifactsDir)toolset\</ArtifactsToolsetDir>
    <ArtifactsObjDir>$(ArtifactsDir)obj\</ArtifactsObjDir>
    <ArtifactsBinDir>$(ArtifactsDir)bin\</ArtifactsBinDir>
    <ArtifactsLogDir>$(ArtifactsDir)log\$(Configuration)\</ArtifactsLogDir>
    <ArtifactsTmpDir>$(ArtifactsDir)tmp\$(Configuration)\</ArtifactsTmpDir>
    <ArtifactsTestResultsDir>$(ArtifactsDir)TestResults\$(Configuration)\</ArtifactsTestResultsDir>
    <ArtifactsSymStoreDirectory>$(ArtifactsDir)SymStore\$(Configuration)\</ArtifactsSymStoreDirectory>
    <ArtifactsPackagesDir>$(ArtifactsDir)packages\$(Configuration)\</ArtifactsPackagesDir>
    <ArtifactsShippingPackagesDir>$(ArtifactsPackagesDir)Shipping\</ArtifactsShippingPackagesDir>
    <ArtifactsNonShippingPackagesDir>$(ArtifactsPackagesDir)NonShipping\</ArtifactsNonShippingPackagesDir>
    <VisualStudioSetupOutputPath>$(ArtifactsDir)VSSetup\$(Configuration)\</VisualStudioSetupOutputPath>
    <VisualStudioSetupInsertionPath>$(VisualStudioSetupOutputPath)Insertion\</VisualStudioSetupInsertionPath>
    <VisualStudioSetupIntermediateOutputPath>$(ArtifactsDir)VSSetup.obj\$(Configuration)\</VisualStudioSetupIntermediateOutputPath>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\ProjectLayout.props
============================================================================================================================================
-->
  <PropertyGroup xmlns="">
    <OutDirName Condition="'$(OutDirName)' == ''">$(MSBuildProjectName)</OutDirName>
    <BaseOutputPath Condition="'$(BaseOutputPath)' == ''">$([System.IO.Path]::GetFullPath('$(ArtifactsBinDir)$(OutDirName)\'))</BaseOutputPath>
    <OutputPath Condition="'$(PlatformName)' == 'AnyCPU'">$(BaseOutputPath)$(Configuration)\</OutputPath>
    <OutputPath Condition="'$(PlatformName)' != 'AnyCPU'">$(BaseOutputPath)$(PlatformName)\$(Configuration)\</OutputPath>
    <BaseIntermediateOutputPath Condition="'$(BaseIntermediateOutputPath)' == ''">$([System.IO.Path]::GetFullPath('$(ArtifactsObjDir)$(OutDirName)\'))</BaseIntermediateOutputPath>
    <IntermediateOutputPath Condition="'$(PlatformName)' == 'AnyCPU'">$(BaseIntermediateOutputPath)$(Configuration)\</IntermediateOutputPath>
    <IntermediateOutputPath Condition="'$(PlatformName)' != 'AnyCPU'">$(BaseIntermediateOutputPath)$(PlatformName)\$(Configuration)\</IntermediateOutputPath>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="DefaultVersions.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\DefaultVersions.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <!--
    Sets versions of packages used by the toolset unless they were already specified by the repo.
    Version.props shall be imported prior this file.
  -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <OfficialBuild>false</OfficialBuild>
    <OfficialBuild Condition="'$(OfficialBuildId)' != ''">true</OfficialBuild>
  </PropertyGroup>
  <!--
============================================================================================================================================
  <Import Project="$(VersionsPropsPath)">

E:\gh\shawnro\core-setup\eng\Versions.props
============================================================================================================================================
-->
  <PropertyGroup>
    <VersionPrefix>1.0.0</VersionPrefix>
    <PreReleaseVersionLabel Condition="'$(PackageVersionStamp)' != ''">$(PackageVersionStamp)</PreReleaseVersionLabel>
    <PreReleaseVersionLabel Condition="'$(PreReleaseVersionLabel)' == ''">preview1</PreReleaseVersionLabel>
    <!-- Libs -->
    <FeedTasksPackage>Microsoft.DotNet.Build.Tasks.Feed</FeedTasksPackage>
    <FeedTasksPackageVersion>3.0.0-preview1-03322-02</FeedTasksPackageVersion>
    <!-- Copy/paste from old dir.props -->
    <!-- SHAWNR
    <StabilizePackageVersion Condition="'$(StabilizePackageVersion)' == ''">false</StabilizePackageVersion>

    <IncludePreReleaseLabelInPackageVersion Condition="'$(StabilizePackageVersion)' != 'true' or '$(PackageVersionStamp)' != ''">true</IncludePreReleaseLabelInPackageVersion>
    <IncludeBuildNumberInPackageVersion Condition="'$(StabilizePackageVersion)' != 'true'">true</IncludeBuildNumberInPackageVersion>

    <ReleaseSuffix>$(PreReleaseLabel)</ReleaseSuffix>
    <ReleaseBrandSuffix>Preview 1</ReleaseBrandSuffix>
    <Channel>master</Channel>
    <ContainerName>dotnet</ContainerName>
    <ChecksumContainerName>$(ContainerName)</ChecksumContainerName>
    <NETCoreAppMaximumVersion>$(MajorVersion).$(MinorVersion)</NETCoreAppMaximumVersion>
-->
    <!-- End copy/paste -->
    <!--
      This name is used to create a GIT repository URL https://github.com/dotnet/$(GitHubRepositoryName) used to find source code for debugging
      It is also used to name the build output manifest for orchestrated builds.
    -->
    <!-- SHAWNR
    <GitHubRepositoryName Condition="'$(GitHubRepositoryName)' == ''">core-setup</GitHubRepositoryName>
-->
    <!-- Opt-out repo features -->
    <!-- SHAWNR
    <UsingToolNetFrameworkReferenceAssemblies>true</UsingToolNetFrameworkReferenceAssemblies>
    <MicrosoftNetFrameworkReferenceAssembliesVersion>1.0.0-alpha-004</MicrosoftNetFrameworkReferenceAssembliesVersion>
-->
    <!-- Libs -->
    <!-- <NewtonsoftJsonVersion>9.0.1</NewtonsoftJsonVersion> -->
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\DefaultVersions.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="Version.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Version.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <!--
    Specification: https://github.com/dotnet/arcade/blob/master/Documentation/Versioning.md
    
    Properties:
      SemanticVersioningV1  "true" if the Version needs to respect SemVer 1.0. Default is false, which means format following SemVer 2.0.
      
    Global settings:
      DotNetUseShippingVersions   
        - "true" to produce shipping versions in non-official builds, instead of default fixed dummy version number (42.42.42.42).
        - A builds target that produces MSI shall fail if DotNetUseShippingVersions == false, since MSIs require increasing file versions to function properly.
  -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <!-- 
    The project can specify version either directly using the .NET SDK recognized property VersionPrefix,
    or using MajorVersion and MinorVersion properties.
  -->
  <PropertyGroup xmlns="">
    <VersionPrefix Condition="'$(VersionPrefix)' == '' and '$(MajorVersion)' != '' and '$(MinorVersion)' != ''">$(MajorVersion).$(MinorVersion).0</VersionPrefix>
  </PropertyGroup>
  <Choose xmlns="">
    <When Condition="'$(OfficialBuild)' == 'true' or '$(DotNetUseShippingVersions)' == 'true'">
      <PropertyGroup>
        <!--
          Building MSIs from dev build requires file versions to be increasing. 
          Use the current date in non-official builds. Note that this reduces the deterministic properties of the build 
          and should only be enabled when it's necessary to test-install the MSIs produced by the build.
        -->
        <_BuildNumber>$(OfficialBuildId)</_BuildNumber>
        <_BuildNumber Condition="'$(OfficialBuildId)' == ''">$([System.DateTime]::Now.ToString(yyyyMMdd)).1</_BuildNumber>
        <!--
          Official build PackageVersion format: MAJOR.MINOR.PATCH-PRERELEASE.SHORTDATE.REVISION+SHORTSHA

          MAJOR.MINOR.PATCH is specified by the project in VersionPrefix property.
          PRERELEASE.SHORTDATE.REVISION is calculated here and stored in VersionSuffix property.
          SHORTSHA is appended when PackageVersion is calculated in a target.

          OfficialBuildId is assumed to have format "yyyyMMdd.r" (the assumption is checked later in a target).
          REVISION (VersionSuffixBuildOfTheDay) is set to r component of OfficialBuildId.
          SHORTDATE (VersionSuffixDateStamp) is set to yy * 1000 + mm * 50 + dd.
        -->
        <_BuildNumberYY>$(_BuildNumber.Substring($([System.Convert]::ToInt32(2)), $([System.Convert]::ToInt32(2))))</_BuildNumberYY>
        <_BuildNumberMM>$(_BuildNumber.Substring($([System.Convert]::ToInt32(4)), $([System.Convert]::ToInt32(2))))</_BuildNumberMM>
        <_BuildNumberDD>$(_BuildNumber.Substring($([System.Convert]::ToInt32(6)), $([System.Convert]::ToInt32(2))))</_BuildNumberDD>
        <_BuildNumberR>$(_BuildNumber.Substring($([System.Convert]::ToInt32(9))))</_BuildNumberR>
        <!-- yy * 1000 + mm * 50 + dd -->
        <VersionSuffixDateStamp>$([MSBuild]::Add($([MSBuild]::Add($([MSBuild]::Multiply($([System.Convert]::ToInt32($(_BuildNumberYY))), $([System.Convert]::ToInt32(1000)))), $([MSBuild]::Multiply($([System.Convert]::ToInt32($(_BuildNumberMM))), $([System.Convert]::ToInt32(50)))))), $([System.Convert]::ToInt32($(_BuildNumberDD)))))</VersionSuffixDateStamp>
        <VersionSuffixBuildOfTheDay>$([System.Convert]::ToInt32($(_BuildNumberR)))</VersionSuffixBuildOfTheDay>
        <VersionSuffixBuildOfTheDayPadded>$(VersionSuffixBuildOfTheDay.PadLeft($([System.Convert]::ToInt32(2)), $([System.Convert]::ToChar(`0`))))</VersionSuffixBuildOfTheDayPadded>
        <_BuildNumberSuffix Condition="'$(SemanticVersioningV1)' != 'true'">.$(VersionSuffixDateStamp).$(VersionSuffixBuildOfTheDay)</_BuildNumberSuffix>
        <_BuildNumberSuffix Condition="'$(SemanticVersioningV1)' == 'true'">-$(VersionSuffixDateStamp)-$(VersionSuffixBuildOfTheDayPadded)</_BuildNumberSuffix>
      </PropertyGroup>
    </When>
    <Otherwise>
      <PropertyGroup>
        <VersionSuffixDateStamp />
        <VersionSuffixBuildOfTheDay />
        <VersionSuffixBuildOfTheDayPadded />
        <_BuildNumberSuffix />
        <!--
          Don't include a commit SHA to AssemblyInformationalVersion. 
          It would reduce the possibility of sharing otherwise unchanged build artifacts across deterministic builds.
        -->
        <IncludeSourceRevisionInInformationalVersion>false</IncludeSourceRevisionInInformationalVersion>
      </PropertyGroup>
    </Otherwise>
  </Choose>
  <PropertyGroup xmlns="">
    <_PreReleaseLabel>$(PreReleaseVersionLabel)</_PreReleaseLabel>
    <_PreReleaseLabel Condition="'$(ContinuousIntegrationBuild)' == 'true' and '$(OfficialBuild)' != 'true'">ci</_PreReleaseLabel>
    <_PreReleaseLabel Condition="'$(ContinuousIntegrationBuild)' != 'true'">dev</_PreReleaseLabel>
    <!--
      If DotNetFinalVersionKind is specified, overrides the package version produced by the build like so:
        ""           1.2.3-beta.12345.67+sha
        "prerelease" 1.2.3-beta+sha
        "release"    1.2.3
    -->
    <VersionSuffix Condition="'$(DotNetFinalVersionKind)' == 'release'" />
    <VersionSuffix Condition="'$(DotNetFinalVersionKind)' == 'prerelease' and '$(SemanticVersioningV1)' != 'true'">$(_PreReleaseLabel).final</VersionSuffix>
    <VersionSuffix Condition="'$(DotNetFinalVersionKind)' == 'prerelease' and '$(SemanticVersioningV1)' == 'true'">$(_PreReleaseLabel)-final</VersionSuffix>
    <VersionSuffix Condition="'$(DotNetFinalVersionKind)' == ''">$(_PreReleaseLabel)$(_BuildNumberSuffix)</VersionSuffix>
    <!-- 
      Disable NuGet Pack warning that the version is SemVer 2.0.
      SemVer 2.0 is supported by NuGet since 3.0.0 (July 2015) in some capacity, and fully since 3.5.0 (October 2016).
    -->
    <NoWarn Condition="'$(SemanticVersioningV1)' != 'true'">$(NoWarn);NU5105</NoWarn>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\DefaultVersions.props
============================================================================================================================================
-->
  <PropertyGroup xmlns="">
    <!-- 
      Configure NuGet Restore to only use NuGet.config file in the repository root.
      This makes sure we do not depend on any NuGet.config files located outside of the repository.
      
      Note: This setting only applies to command-line build, not design time builds done from Visual Studio.
      Visual Studio restore might still use other NuGet.config files.
    -->
    <RestoreConfigFile>$(RepoRoot)NuGet.config</RestoreConfigFile>
    <!-- Opt-out features -->
    <UsingToolXliff Condition="'$(UsingToolXliff)' == ''">true</UsingToolXliff>
    <UsingToolXUnit Condition="'$(UsingToolXUnit)' == ''">true</UsingToolXUnit>
    <UsingToolPdbConverter Condition="'$(UsingToolPdbConverter)' == ''">true</UsingToolPdbConverter>
    <!--
      Always use compilers from the package on CI build, to get consistent results.
      Locally we want to dogfood the compilers that come with the dotnet SDK or msbuild used to build the repo.
      The local compilers are also precompiled and thus faster.
      Repo can set this property to true for local builds if it needs to use newer compiler than the one in the dotnet SDK.
    -->
    <UsingToolMicrosoftNetCompilers Condition="'$(ContinuousIntegrationBuild)' == 'true'">true</UsingToolMicrosoftNetCompilers>
    <!-- Opt-in features -->
    <UsingToolVSSDK Condition="'$(UsingToolVSSDK)' == ''">false</UsingToolVSSDK>
    <UsingToolIbcOptimization Condition="'$(UsingToolIbcOptimization)' == ''">false</UsingToolIbcOptimization>
    <UsingToolNetFrameworkReferenceAssemblies Condition="'$(UsingToolNetFrameworkReferenceAssemblies)' == ''">false</UsingToolNetFrameworkReferenceAssemblies>
    <UsingToolNuGetRepack Condition="'$(UsingToolNuGetRepack)' == ''">false</UsingToolNuGetRepack>
    <UsingToolSymbolUploader Condition="'$(UsingToolSymbolUploader)' == ''">false</UsingToolSymbolUploader>
    <!-- Default versions -->
    <MicroBuildPluginsSwixBuildVersion Condition="'$(MicroBuildPluginsSwixBuildVersion)' == ''">1.0.422</MicroBuildPluginsSwixBuildVersion>
    <MicroBuildCoreVersion Condition="'$(MicroBuildCoreVersion)' == ''">0.2.0</MicroBuildCoreVersion>
    <MicrosoftDotNetIBCMergeVersion Condition="'$(MicrosoftDotNetIBCMergeVersion)' == ''">4.7.1-alpha-00001</MicrosoftDotNetIBCMergeVersion>
    <MicrosoftNetCompilersVersion Condition="'$(MicrosoftNetCompilersVersion)' == ''">2.8.0</MicrosoftNetCompilersVersion>
    <MicrosoftNETCoreCompilersVersion Condition="'$(MicrosoftNETCoreCompilersVersion)' == ''">$(MicrosoftNetCompilersVersion)</MicrosoftNETCoreCompilersVersion>
    <!-- Using a private build of Microsoft.Net.Test.SDK to work around issue https://github.com/Microsoft/vstest/issues/373 -->
    <MicrosoftNETTestSdkVersion Condition="'$(MicrosoftNETTestSdkVersion)' == ''">15.6.0-dev</MicrosoftNETTestSdkVersion>
    <MicrosoftNetFrameworkReferenceAssembliesVersion Condition="'$(MicrosoftNetFrameworkReferenceAssembliesVersion)' == ''">1.0.0-alpha-004</MicrosoftNetFrameworkReferenceAssembliesVersion>
    <MicrosoftVSSDKBuildToolsVersion Condition="'$(MicrosoftVSSDKBuildToolsVersion)' == ''">15.1.192</MicrosoftVSSDKBuildToolsVersion>
    <MicrosoftDiaSymReaderPdb2PdbVersion Condition="'$(MicrosoftDiaSymReaderPdb2PdbVersion)' == ''">1.1.0-beta1-62506-02</MicrosoftDiaSymReaderPdb2PdbVersion>
    <RoslynToolsModifyVsixManifestVersion Condition="'$(RoslynToolsModifyVsixManifestVersion)' == ''">1.0.0-beta2-63208-02</RoslynToolsModifyVsixManifestVersion>
    <RoslynToolsNuGetRepackVersion Condition="'$(RoslynToolsNuGetRepackVersion)' == ''">1.0.0-beta2-63223-01</RoslynToolsNuGetRepackVersion>
    <MicrosoftDotNetSignToolVersion Condition="'$(MicrosoftDotNetSignToolVersion)' == ''">1.0.0-beta.18511.3</MicrosoftDotNetSignToolVersion>
    <XliffTasksVersion Condition="'$(XliffTasksVersion)' == ''">0.2.0-beta-63004-01</XliffTasksVersion>
    <XUnitVersion Condition="'$(XUnitVersion)' == ''">2.4.1-pre.build.4059</XUnitVersion>
    <XUnitRunnerConsoleVersion Condition="'$(XUnitRunnerConsoleVersion)' == ''">$(XUnitVersion)</XUnitRunnerConsoleVersion>
    <XUnitRunnerVisualStudioVersion Condition="'$(XUnitRunnerVisualStudioVersion)' == ''">$(XUnitVersion)</XUnitRunnerVisualStudioVersion>
    <MicrosoftDotNetBuildTasksFeedVersion Condition="'$(MicrosoftDotNetBuildTasksFeedVersion)' == ''">2.2.0-beta.18475.5</MicrosoftDotNetBuildTasksFeedVersion>
    <MicrosoftSourceLinkVersion Condition="'$(MicrosoftSourceLinkVersion)' == ''">1.0.0-beta-63201-01</MicrosoftSourceLinkVersion>
    <MicrosoftSymbolUploaderBuildTaskVersion Condition="'$(MicrosoftSymbolUploaderBuildTaskVersion)' == ''">1.0.0-beta-63008-01</MicrosoftSymbolUploaderBuildTaskVersion>
    <VSWhereVersion Condition="'$(VSWhereVersion)' == ''">2.5.2</VSWhereVersion>
    <MicrosoftDotNetMaestroTasksVersion Condition="'$(MicrosoftDotNetMaestroTasksVersion)' == ''">1.0.0-beta.18478.2</MicrosoftDotNetMaestroTasksVersion>
  </PropertyGroup>
  <!-- RestoreSources overrides - defines DotNetRestoreSources variable if available -->
  <!--<Import Project="$(DotNetRestoreSourcePropsPath)" Condition="'$(DotNetRestoreSourcePropsPath)' != ''" />-->
  <!-- Force sources to DotNetRestoreSources if building offline, discard any sources set by the repo -->
  <PropertyGroup Condition="'$(DotNetBuildOffline)' == 'true'" xmlns="">
    <RestoreSources>$(DotNetRestoreSources)</RestoreSources>
  </PropertyGroup>
  <PropertyGroup Condition="'$(DotNetBuildOffline)' != 'true'" xmlns="">
    <RestoreSources>$(RestoreSources);https://api.nuget.org/v3/index.json</RestoreSources>
    <RestoreSources Condition="'$(UsingToolXliff)' == 'true' and $(XliffTasksVersion.Contains('-'))">$(RestoreSources);https://dotnet.myget.org/F/dotnet-core/api/v3/index.json</RestoreSources>
    <RestoreSources Condition="'$(UsingToolMicrosoftNetCompilers)' == 'true' and $(MicrosoftNetCompilersVersion.Contains('-'))">$(RestoreSources);https://dotnet.myget.org/F/roslyn/api/v3/index.json</RestoreSources>
    <RestoreSources Condition="'$(UsingToolNetFrameworkReferenceAssemblies)' == 'true'">$(RestoreSources);https://dotnet.myget.org/F/roslyn-tools/api/v3/index.json</RestoreSources>
    <RestoreSources Condition="$(XUnitVersion.Contains('-')) or $(XUnitRunnerVisualStudioVersion.Contains('-')) or $(XUnitRunnerVisualStudioVersion.Contains('-'))">$(RestoreSources);https://www.myget.org/F/xunit/api/v3/index.json</RestoreSources>
    <RestoreSources Condition="$(MicrosoftSourceLinkVersion.Contains('-'))">$(RestoreSources);https://dotnet.myget.org/F/sourcelink/api/v3/index.json</RestoreSources>
    <!-- Using a private build of Microsoft.Net.Test.SDK to work around issue https://github.com/Microsoft/vstest/issues/373 -->
    <RestoreSources Condition="'$(MicrosoftNETTestSdkVersion)' == '15.6.0-dev'">$(RestoreSources);https://dotnet.myget.org/F/roslyn-tools/api/v3/index.json</RestoreSources>
    <RestoreSources Condition="'$(DotNetRestoreSources)' != ''">$(DotNetRestoreSources);$(RestoreSources)</RestoreSources>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="StrongName.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\StrongName.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <MicrosoftSharedPublicKey>0024000004800000940000000602000000240000525341310004000001000100b5fc90e7027f67871e773a8fde8938c81dd402ba65b9201d60593e96c492651e889cc13f1415ebb53fac1131ae0bd333c5ee6021672d9718ea31a8aebd0da0072f25d87dba6fc90ffd598ed4da35e44c398c454307e8e33b8426143daec9f596836f97c8f74750e5975c64e2189f45def46b2a2b1247adc3652bf5c308055da9</MicrosoftSharedPublicKey>
    <MicrosoftPublicKey>002400000480000094000000060200000024000052534131000400000100010007d1fa57c4aed9f0a32e84aa0faefd0de9e8fd6aec8f87fb03766c834c99921eb23be79ad9d5dcc1dd9ad236132102900b723cf980957fc4e177108fc607774f29e8320e92ea05ece4e821c0a5efe8f1645c4c0c93c1ab99285d622caa652c1dfad63d745d6f2de5f17e5eaf0fc4963d261c8a12436518206dc093344d5ad293</MicrosoftPublicKey>
    <MicrosoftAspNetPublicKey>0024000004800000940000000602000000240000525341310004000001000100f33a29044fa9d740c9b3213a93e57c84b472c84e0b8a0e1ae48e67a9f8f6de9d5f7f3d52ac23e48ac51801f1dc950abe901da34d2a9e3baadb141a17c77ef3c565dd5ee5054b91cf63bb3c6ab83f72ab3aafe93d0fc3c2348b764fafb0b1c0733de51459aeab46580384bf9d74c4e28164b7cde247f891ba07891c9d872ad2bb</MicrosoftAspNetPublicKey>
    <ECMAPublicKey>00000000000000000400000000000000</ECMAPublicKey>
    <OpenPublicKey>00240000048000009400000006020000002400005253413100040000010001004b86c4cb78549b34bab61a3b1800e23bfeb5b3ec390074041536a7e3cbd97f5f04cf0f857155a8928eaa29ebfd11cfbbad3ba70efea7bda3226c6a8d370a4cd303f714486b6ebc225985a638471e6ef571cc92a4613c00b8fa65d61ccee0cbe5f36330c9a01f4183559f1bef24cc2917c6d913e3a541333a1d05d9bed22b38cb</OpenPublicKey>
    <SilverlightPlatformPublicKey>00240000048000009400000006020000002400005253413100040000010001008d56c76f9e8649383049f383c44be0ec204181822a6c31cf5eb7ef486944d032188ea1d3920763712ccb12d75fb77e9811149e6148e5d32fbaab37611c1878ddc19e20ef135d0cb2cff2bfec3d115810c3d9069638fe4be215dbf795861920e5ab6f7db2e2ceef136ac23d5dd2bf031700aec232f6c6b1c785b4305c123b37ab</SilverlightPlatformPublicKey>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="ProjectDefaults.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\ProjectDefaults.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <SignAssembly>true</SignAssembly>
    <StrongNameKeyId>MicrosoftShared</StrongNameKeyId>
    <ChecksumAlgorithm>SHA256</ChecksumAlgorithm>
    <HighEntropyVA>true</HighEntropyVA>
    <NeutralLanguage>en-US</NeutralLanguage>
    <Company>Microsoft Corporation</Company>
    <Copyright>© Microsoft Corporation. All rights reserved.</Copyright>
    <Authors>Microsoft</Authors>
    <Serviceable>true</Serviceable>
    <DevelopmentDependency>false</DevelopmentDependency>
    <PackageRequireLicenseAcceptance>true</PackageRequireLicenseAcceptance>
    <PackageLicenseUrl>http://go.microsoft.com/fwlink/?LinkId=529443</PackageLicenseUrl>
    <PublishRepositoryUrl>true</PublishRepositoryUrl>
    <!-- Disable the message indicating we are using a preview SDK. That is understood and by design -->
    <SuppressNETCoreSdkPreviewMessage>true</SuppressNETCoreSdkPreviewMessage>
    <!-- By default do not build NuGet package for a project. Project may override. -->
    <IsPackable>false</IsPackable>
    <!--
      Official build:
       - Build standalone Portable PDBs to reduce the size of the binaries.
       - Convert Portable PDBs to Windows PDBs and publish the converted PDBs to Symbol Store to allow WinDBG, 
         Watson and other tools to find symbol format they understand.

      Jenkins build:
       - Embed PDBs to make it easier to debug Jenkins crash dumps.

      Developer build:
       - Embed PDBs to be consistent with Jenkins builds.    
    -->
    <DebugType>portable</DebugType>
    <DebugType Condition="'$(OfficialBuild)' != 'true'">embedded</DebugType>
    <!-- 
      This controls the places MSBuild will consult to resolve assembly references.  This is 
      kept as minimal as possible to make our build reliable from machine to machine.  Global
      locations such as GAC, AssemblyFoldersEx, etc ... are deliberately removed from this 
      list as they will not be the same from machine to machine.
    -->
    <AssemblySearchPaths>
      {HintPathFromItem};
      {TargetFrameworkDirectory};
      {RawFileName};
    </AssemblySearchPaths>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <Language Condition="'$(MSBuildProjectExtension)' == '.csproj'">C#</Language>
    <Language Condition="'$(MSBuildProjectExtension)' == '.vbproj'">VB</Language>
    <Language Condition="'$(MSBuildProjectExtension)' == '.fsproj'">F#</Language>
    <Language Condition="'$(MSBuildProjectExtension)' == '.vcxproj'">C++</Language>
  </PropertyGroup>
  <!--
    When building WPF / VSIX projects MSBuild will create a temporary project with an extension of
    tmp_proj.  In that case the SDK is unable to determine the target language and cannot pick
    the correct import. Need to set it explicitly here.
    See https://github.com/dotnet/project-system/issues/1467
  -->
  <Choose xmlns="">
    <When Condition="'$(MSBuildProjectExtension)' != '.csproj' and '$(MSBuildProjectExtension)' != '.vbproj' and '$(MSBuildProjectExtension)' != '.shproj'">
      <Choose>
        <When Condition="'$(Language)' == 'C#' or Exists('$(MSBuildProjectDirectory)\$(AssemblyName).csproj')">
          <PropertyGroup>
            <Language>C#</Language>
            <LanguageTargets>$(MSBuildToolsPath)\Microsoft.CSharp.targets</LanguageTargets>
          </PropertyGroup>
        </When>
        <When Condition="'$(Language)' == 'VB' or Exists('$(MSBuildProjectDirectory)\$(AssemblyName).vbproj')">
          <PropertyGroup>
            <Language>VB</Language>
            <LanguageTargets>$(MSBuildToolsPath)\Microsoft.VisualBasic.targets</LanguageTargets>
          </PropertyGroup>
        </When>
      </Choose>
    </When>
  </Choose>
  <Choose xmlns="">
    <!-- C# specific settings -->
    <When Condition="'$(Language)' == 'C#'">
      <PropertyGroup>
        <CheckForOverflowUnderflow>true</CheckForOverflowUnderflow>
        <NoWarn>$(NoWarn);1701;1702;1705;1591</NoWarn>
      </PropertyGroup>
      <PropertyGroup Condition="'$(Configuration)' == 'Debug'">
        <DebugSymbols>true</DebugSymbols>
        <DefineConstants>DEBUG;TRACE</DefineConstants>
      </PropertyGroup>
      <PropertyGroup Condition="'$(Configuration)' == 'Release'">
        <DefineConstants>TRACE</DefineConstants>
        <Optimize>true</Optimize>
      </PropertyGroup>
    </When>
    <!-- VB specific settings -->
    <When Condition="'$(Language)' == 'VB'">
      <PropertyGroup>
        <MyType>Empty</MyType>
        <OptionCompare>Binary</OptionCompare>
        <OptionExplicit>On</OptionExplicit>
        <OptionInfer>On</OptionInfer>
        <OptionStrict>On</OptionStrict>
        <VBRuntime>Embed</VBRuntime>
        <RemoveIntegerChecks>true</RemoveIntegerChecks>
      </PropertyGroup>
      <PropertyGroup Condition="'$(Configuration)' == 'Debug'">
        <DebugSymbols>true</DebugSymbols>
        <DefineDebug>true</DefineDebug>
        <DefineTrace>true</DefineTrace>
      </PropertyGroup>
      <PropertyGroup Condition="'$(Configuration)' == 'Release'">
        <DefineTrace>true</DefineTrace>
        <Optimize>true</Optimize>
      </PropertyGroup>
    </When>
    <!-- F# specific settings -->
    <When Condition="'$(Language)' == 'F#'">
      <PropertyGroup>
        <!-- F# compiler doesn't support PathMap (see https://github.com/Microsoft/visualfsharp/issues/3812) -->
        <DeterministicSourcePaths>false</DeterministicSourcePaths>
      </PropertyGroup>
    </When>
  </Choose>
  <!-- 
    Implements proposal https://github.com/dotnet/designs/pull/33.
  -->
  <ItemGroup Condition="'$(UsingToolNetFrameworkReferenceAssemblies)' == 'true'" xmlns="">
    <PackageReference Include="Microsoft.NETFramework.ReferenceAssemblies" Version="$(MicrosoftNetFrameworkReferenceAssembliesVersion)" PrivateAssets="all" IsImplicitlyDefined="true" />
  </ItemGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  <Import Project="Tests.props">

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Tests.props
============================================================================================================================================
-->
  <!-- All Rights Reserved. Licensed to the .NET Foundation under one or more agreements. The .NET Foundation licenses this file to you under the MIT license. See the LICENSE file in the project root for more information. -->
  <PropertyGroup xmlns="">
    <MSBuildAllProjects>$(MSBuildAllProjects);$(MSBuildThisFileFullPath)</MSBuildAllProjects>
  </PropertyGroup>
  <PropertyGroup Condition="'$(IsPerformanceTestProject)' == ''" xmlns="">
    <IsPerformanceTestProject>false</IsPerformanceTestProject>
    <IsPerformanceTestProject Condition="$(MSBuildProjectName.EndsWith('.PerformanceTests'))">true</IsPerformanceTestProject>
  </PropertyGroup>
  <PropertyGroup Condition="'$(IsIntegrationTestProject)' == ''" xmlns="">
    <IsIntegrationTestProject>false</IsIntegrationTestProject>
    <IsIntegrationTestProject Condition="$(MSBuildProjectName.EndsWith('.IntegrationTests'))">true</IsIntegrationTestProject>
  </PropertyGroup>
  <PropertyGroup Condition="'$(IsUnitTestProject)' == ''" xmlns="">
    <IsUnitTestProject>false</IsUnitTestProject>
    <IsUnitTestProject Condition="$(MSBuildProjectName.EndsWith('.UnitTests')) or $(MSBuildProjectName.EndsWith('.Tests'))">true</IsUnitTestProject>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <IsTestProject>false</IsTestProject>
    <IsTestProject Condition="'$(IsUnitTestProject)' == 'true' or '$(IsIntegrationTestProject)' == 'true' or '$(IsPerformanceTestProject)' == 'true'">true</IsTestProject>
    <!-- Disable building Integration Test projects in LUT. -->
    <BuildForLiveUnitTesting Condition="'$(BuildForLiveUnitTesting)' == '' and '$(IsIntegrationTestProject)' == 'true'">false</BuildForLiveUnitTesting>
  </PropertyGroup>
  <ItemGroup Condition="'$(IsTestProject)' == 'true'" xmlns="">
    <!-- VS TestExplorer uses this to identify a test project -->
    <Service Include="{82a7f48d-3b50-4b1e-b82e-3ada8210c358}" />
    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="$(MicrosoftNETTestSdkVersion)" IsImplicitlyDefined="true" />
  </ItemGroup>
  <PropertyGroup Condition="'$(IsTestProject)' == 'true'" xmlns="">
    <!-- Treat test assemblies as non-shipping (do not publish or sign them). -->
    <IsShipping Condition="'$(IsShipping)' == ''">false</IsShipping>
    <!-- Default test runner -->
    <TestRunnerName Condition="'$(UsingToolXUnit)' == 'true'">XUnit</TestRunnerName>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\tools\Settings.props
============================================================================================================================================
-->
  <!--<Import Project="Compiler.props" Condition="'$(UsingToolMicrosoftNetCompilers)' == 'true'" />-->
  <!--<Import Project="VisualStudio.props" Condition="'$(UsingToolVSSDK)' == 'true'" />-->
  <!-- Directory.Build.props are imported next by .NET SDK (via Common.targets) -->
  <!--<Import Project="Sdk.props" Sdk="Microsoft.NET.Sdk" Condition="'$(ImportNetSdkFromRepoToolset)' == 'true'" />-->
  <!--
============================================================================================================================================
  </Import>

C:\Users\chcosta\.nuget\packages\microsoft.dotnet.arcade.sdk\1.0.0-beta.18524.2\Sdk\Sdk.props
============================================================================================================================================
-->
  <!--
============================================================================================================================================
  </Import>

E:\gh\shawnro\core-setup\Directory.Build.props
============================================================================================================================================
-->
  <!--  
  <PropertyGroup>
    <MajorVersion>3</MajorVersion>
    <MinorVersion>0</MinorVersion>
    <PatchVersion>0</PatchVersion>
  </PropertyGroup>
-->
  <!--
    $(OS) is set to Unix/Windows_NT. This comes from an environment variable on Windows and MSBuild on Unix.
  -->
  <PropertyGroup xmlns="">
    <!-- Temp change to make OS X build behave as a Linux build -->
    <OsEnvironment Condition="'$(OsEnvironment)'=='' AND '$(OS)'=='OSX'">Unix</OsEnvironment>
    <OsEnvironment Condition="'$(OsEnvironment)'==''">$(OS)</OsEnvironment>
  </PropertyGroup>
  <PropertyGroup xmlns="">
    <OSGroup Condition="'$(OSGroup)' == ''">$(OsEnvironment)</OSGroup>
  </PropertyGroup>
  <!--
============================================================================================================================================
  </Import>

E:\gh\shawnro\core-setup\build.proj
============================================================================================================================================
-->
  <!-- required to build the projects in their specified order -->
  <PropertyGroup>
    <SerializeProjects>true</SerializeProjects>
  </PropertyGroup>
  <PropertyGroup>
    <!-- To disable the restoration of packages, set RestoreDuringBuild=false or pass /p:RestoreDuringBuild=false.-->
    <!-- SHAWNR <RestoreDuringBuild Condition="'$(RestoreDuringBuild)'==''">true</RestoreDuringBuild> -->
    <BuildRestore Condition="'$(BuildRestore)'==''">true</BuildRestore>
    <BuildNative Condition="'$(BuildNative)'==''">true</BuildNative>
    <BuildTests Condition="'$(BuildTests)'==''">false</BuildTests>
    <BuildPackages Condition="'$(BuildPackages)'==''">true</BuildPackages>
    <BuildDependsOn Condition="'$(BuildRestore)'=='true'">$(BuildDependsOn);Restore</BuildDependsOn>
    <BuildDependsOn>$(BuildDependsOn);BuildHost</BuildDependsOn>
    <BuildDependsOn Condition="'$(BuildManaged)'=='true'">$(BuildDependsOn);BuildManaged</BuildDependsOn>
    <BuildDependsOn Condition="'$(BuildTests)'=='true'">$(BuildDependsOn);Test</BuildDependsOn>
    <!-- SHAWNR
    <BuildDependsOn Condition="'$(BuildPackages)'=='true'">$(BuildDependsOn);Pack</BuildDependsOn>    
    -->
  </PropertyGroup>
  <Target Name="Restore">
    <ItemGroup>
      <!-- SHAWNR <_RestoreProjects Include="external\dir.proj" /> -->
    </ItemGroup>
    <!-- Generate the configurations for this repo -->
    <!-- SHAWNR
    <GenerateConfigurationProps Properties="@(Property)" PropertyValues="@(PropertyValue)" PropsFolder="$(BuildConfigurationFolder)" />
-->
    <MSBuild Projects="@(_RestoreProjects)" Properties="$(ProjectProperties)" />
  </Target>
  <Target Name="BuildHost">
    <ItemGroup>
      <_BuildHostProjects Include="src/dir.proj" />
    </ItemGroup>
    <MSBuild Projects="@(_BuildHostProjects)" Properties="$(ProjectProperties)" />
  </Target>
  <Target Name="Build" DependsOnTargets="$(BuildDependsOn)" />
  <!-- SHAWNR
  <PropertyGroup>
    <TraversalBuildDependencies>
      CreateOrUpdateCurrentVersionFile;
      CreateVersionInfoFile;
      CreateHostMachineInfoFile;
      BatchRestorePackages;
      BuildCustomTasks;
    </TraversalBuildDependencies>
    <TraversalBuildDependsOn>
      $(TraversalBuildDependencies);
      $(TraversalBuildDependsOn);
    </TraversalBuildDependsOn>
  </PropertyGroup>
-->
  <ItemGroup>
    <!--    <Project Include="src/dir.proj" /> -->
    <!-- Remove the below line and put it where it goes -->
    <Project Include="src/managed/Microsoft.DotNet.PlatformAbstractions/Microsoft.DotNet.PlatformAbstractions.csproj" />
    <!-- SHAWNR
    <Project Include="src/pkg/packaging/dir.proj"/>
    <Project Include="$(MSBuildThisFileDirectory)src/test/dir.proj" Condition="'$(SkipTests)' != 'true'"/>
    -->
  </ItemGroup>
  <!-- SHAWNR
  <Target Name="BuildTraversalBuildDependencies"
          DependsOnTargets="$(TraversalBuildDependencies)" />

  <Target Name="CreateHostMachineInfoFile">
    <GetTargetMachineInfo>
      <Output PropertyName="HostMachineRid" TaskParameter="RuntimeIdentifier" />
    </GetTargetMachineInfo>

    <PropertyGroup>
      <HostMachineInfoPropsContent>
&lt;Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003"&gt;
  &lt;PropertyGroup&gt;
    &lt;HostMachineRid&gt;$(HostMachineRid)&lt;/HostMachineRid&gt;
  &lt;/PropertyGroup&gt;
&lt;/Project&gt;
      </HostMachineInfoPropsContent>
    </PropertyGroup>

    <WriteLinesToFile File="$(HostMachineInfoProps)"
                      Lines="$(HostMachineInfoPropsContent)"
                      Overwrite="True" />
  </Target>

  <Target Name="BatchRestorePackages" Condition="'$(RestoreDuringBuild)'=='true'">
    <Message Importance="High" Text="Restoring all packages..." />
    <Exec Condition="'@(SdkRestoreProjects)' != ''" Command="$(DotnetRestoreCommand) &quot;%(SdkRestoreProjects.FullPath)&quot; $(MSBuildPassThroughPropertyList)" StandardOutputImportance="Low" />
  </Target>

  <Import Project="dir.targets" />
  <Import Project="dir.traversal.targets" />
  <Import Project="$(ToolsDir)clean.targets" />
  <Import Project="$(ToolsDir)VersionTools.targets" Condition="Exists('$(ToolsDir)VersionTools.targets')" />
-->
  <!-- Override RestorePackages from dir.traversal.targets and do a batch restore -->
  <!-- SHAWNR
  <Target Name="RestorePackages" DependsOnTargets="BatchRestorePackages" />
  -->
  <!-- Override clean from dir.traversal.targets and just remove the full BinDir -->
  <!-- SHAWNR
  <Target Name="CleanAllProjects">
    <RemoveDir Directories="$(BinDir)" />
  </Target>
  -->
</Project>