<?xml version="1.0"?>

<!--
	Common EPS Batch ANT Build Script

	This script will build any of the following batch jobs:

			PPS.*
			SPP.*
			meob

	Call this script as follows:

		ant -f build_pps_batch_job.xml -DjobNum=???

			where ??? is the name of the job (i.e. PPS.0006, PPS.3000, etc.)

-->

<project name="EPS_DTSTG_BATCH" default="all" basedir=".">

<target name="init">

	<!-- Properties for local builds. -->
	<tstamp>
	  <format property="local.build.timestamp" pattern="yyyyMMdd.HHmmss"/>
	</tstamp>
  <property name="anthill.version" value="${local.build.timestamp}"/>


	<tstamp>
		<format property="datestamp" pattern="yyyyMMdd" locale="en" />
	</tstamp>

	<!-- Directories under source folder -->
	<property name="srcDir.base" value="../../executable"/>

	<!-- Destination directory -->
	<property name="destDir.base" value="./dist/EPS_DTSTG_BATCH"/>
	<!--	<property name="deployDir.base" value="./deploy/${DSTAMP}${TSTAMP}"/> -->
	<property name="deployDir.base" value="./deploy"/>

	<!-- Directories under source directory -->
	<property name="commonSrcDir" value="${srcDir.base}/common"/>
	<property name="ppsJobNumSrcDir" value="${srcDir.base}/${jobNum}"/>

	<!-- Directories under destination directory -->
	<property name="commonDestDir" value="${destDir.base}/common"/>
	<property name="ppsJobNumDestDir" value="${destDir.base}/${jobNum}"/>

	<!-- Directories under common directory -->
	<property name="libDir" value="${commonDestDir}/lib"/>

	<!-- Sub directory names under any of PPS.00* directories -->
	<property name="archiveDir" value="archive"/>
	<property name="uniqueDir" value="unique"/>
	<property name="workDir" value="work"/>
	<property name="scriptDir" value="script"/>
	<property name="configDir" value="config"/>
	<property name="skillsDir" value="skills"/>
	<property name="meoblibDir" value="lib"/>
	<property name="jobLibDir" value="lib"/>
	<property name="dbUtilitiesDir" value="dbUtilities"/>
	<property name="fileUtilitiesDir" value="fileUtilities"/>
	<property name="TWS_SIMULATORDir" value="TWS_SIMULATOR"/>
	<property name="lib_VER2_Dir" value="lib_VER2"/>
	<property name="jar_VER2_Dir" value="jar_VER2"/>
	<property name="lib_VER3_Dir" value="lib_VER3"/>

	<property name="ppsJobNumFile" value="${jobNum}-${anthill.version}-${gitRevision}.tar"/>

 	<available property="destDirPresent" file="${destDir.base}"/>

	<!-- Check for various directories -->
 	<available property="uniqueDirPresent" file="${ppsJobNumSrcDir}/unique"/>
 	<available property="configDirPresent" file="${ppsJobNumSrcDir}/config"/>
 	<available property="skillsDirPresent" file="${ppsJobNumSrcDir}/skills"/>
	<available property="jobLibDirPresent" file="${ppsJobNumSrcDir}/lib"/>
	<available property="dbUtilitiesDirPresent" file="${ppsJobNumSrcDir}/dbUtilities"/>
	<available property="fileUtilitiesDirPresent" file="${ppsJobNumSrcDir}/fileUtilities"/>
	<available property="TWS_SIMULATORDirPresent" file="${ppsJobNumSrcDir}/TWS_SIMULATOR"/>
	<available property="lib_VER2_DirPresent" file="${ppsJobNumSrcDir}/lib_VER2"/>
	<available property="jar_VER2_DirPresent" file="${ppsJobNumSrcDir}/jar_VER2"/>
	<available property="lib_VER3_DirPresent" file="${ppsJobNumSrcDir}/lib_VER3"/>



	<antcall target="deleteDestDir"/>

	<mkdir dir="${destDir.base}"/>
	<mkdir dir="${deployDir.base}"/>

</target>

<target name="deleteDestDir">
  <delete verbose="true" includeEmptyDirs="true" failOnError="false">
		<fileset dir="${destDir.base}"/>
  </delete>
  <echo message="Deleting from ${deployDir.base}..."/>
  <delete verbose="true" includeEmptyDirs="true" failOnError="false">
		<fileset dir="${deployDir.base}"/>
  </delete>
</target>



<target name="copyPPSJobNum_Code" >
	<echo message="Copy to ${jobNum} Code Files"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}">
		<fileset dir="${ppsJobNumSrcDir}" includes="*"/>
	</copy>
</target>

<target name="copyPPSJobNum_Script" >
	<echo message="Copy to ${jobNum} Script Files"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${scriptDir}">
		<fileset dir="${ppsJobNumSrcDir}" includes="*"/>
	</copy>
</target>


<target name="copyPPSJobNum_Config" if="configDirPresent">
  <echo message="Copy to config"/>
  <copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${configDir}">
	  <fileset dir="${ppsJobNumSrcDir}/${configDir}" includes="**/*"/>
  </copy>
</target>

<!-- Copy files to skills folder -->
<target name="copyPPSJobNum_Skills" if="skillsDirPresent">
  <echo message="Copy to skills"/>
  <copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${skillsDir}">
	  <fileset dir="${ppsJobNumSrcDir}/${skillsDir}" includes="**/*"/>
  </copy>
</target>

<!-- Copy files to unique folder -->
<target name="copyPPSJobNum_Unique" if="uniqueDirPresent">
	<echo message="Copy to unique"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${uniqueDir}">
		<fileset dir="${ppsJobNumSrcDir}/${uniqueDir}" includes="**/*"/>
	</copy>
</target>

<!-- Copy files to dbUtilities folder -->
<target name="copyPPSJobNum_dbUtilities" if="dbUtilitiesDirPresent">
	<echo message="Copy to dbUtilities"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${dbUtilitiesDir}">
		<fileset dir="${ppsJobNumSrcDir}/${dbUtilitiesDir}" includes="**/*"/>
	</copy>
</target>

<!-- Copy files to fileUtilities folder -->
<target name="copyPPSJobNum_fileUtilities" if="fileUtilitiesDirPresent">
	<echo message="Copy to fileUtilities"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${fileUtilitiesDir}">
		<fileset dir="${ppsJobNumSrcDir}/${fileUtilitiesDir}" includes="**/*"/>
	</copy>
</target>

<!-- Copy files to TWS_SIMULATOR folder -->
<target name="copyPPSJobNum_TWS_SIMULATOR" if="TWS_SIMULATORDirPresent">
	<echo message="Copy to TWS_SIMULATOR"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${TWS_SIMULATORDir}">
		<fileset dir="${ppsJobNumSrcDir}/${TWS_SIMULATORDir}" includes="**/*"/>
	</copy>
</target>

<!-- Copy files to a job's lib folder -->
<target name="copyPPSJobNum_Lib" if="jobLibDirPresent">
	<echo message="Copy to job's lib"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${jobLibDir}">
		<fileset dir="${ppsJobNumSrcDir}/${jobLibDir}" includes="**/*"/>
	</copy>
</target>

	<!-- Copy files to lib ver2 folder -->
<target name="copyPPSJobNum_lib_VER2" if="lib_VER2_DirPresent">
	<echo message="Copy to lib_VER2"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${lib_VER2_Dir}">
		<fileset dir="${ppsJobNumSrcDir}/${lib_VER2_Dir}" includes="**/*"/>
	</copy>
</target>

	<!-- Copy files to jar Ver2 folder -->
<target name="copyPPSJobNum_jar_VER2" if="jar_VER2_DirPresent">
	<echo message="Copy to jar_VER2"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${jar_VER2_Dir}">
		<fileset dir="${ppsJobNumSrcDir}/${jar_VER2_Dir}" includes="**/*"/>
	</copy>
</target>

<!-- Copy files to lib ver3 folder -->
<target name="copyPPSJobNum_lib_VER3" if="lib_VER3_DirPresent">
	<echo message="Copy to lib_VER3"/>
	<copy preserveLastModified="true" todir="${ppsJobNumDestDir}/${lib_VER3_Dir}">
		<fileset dir="${commonSrcDir}/lib_VER3" includes="**/*.jar"/>
	</copy>
</target>

<!-- Create $JobNum.tar under destination directory -->
<target name="PPSJobNumBuildTar">
  <fixcrlf srcDir="${ppsJobNumDestDir}" eol="lf" eof="remove" excludes="**/*.lnx **/*.jar **/*.jpg **/*.pdf **/*.zip"/>
  <tar tarfile="${destDir.base}/${ppsJobNumFile}">
    <tarfileset dir="${ppsJobNumDestDir}" prefix="${jobNum}/">
    	<include name="**/**"/>
    </tarfileset>
  </tar>

  <move file="${destDir.base}/${ppsJobNumFile}" todir="${deployDir.base}"/>

</target>

<!-- Main target for $JobNum -->
<target name="copyPPSJobNum"> <!--   if="ppsJobNum.exists" > -->

	<tstamp>
	  <format property="start_target1.timestamp" pattern="dd-MMM-yy HH:mm:ss"/>
	</tstamp>

  <echo message="Start - copyPPSJobNum(${jobNum}) : ${start_target1.timestamp}"/>

	<echo message="Building Job ${jobNum}..."/>

	<mkdir dir="${ppsJobNumDestDir}"/>


	<propertyfile
	    file="${ppsJobNumDestDir}/ahp_deployed_version.properties"
	    comment="This job was built by Anthill.">
	  <entry  key="Deployed.Anthill.Version" value="${anthill.version}"/>
	  <entry  key="Deployed.Git.Branch" value="${gitBranch}"/>
	  <entry  key="Deployed.Git.Revision" value="${gitRevision}"/>
	</propertyfile>

	<antcall target="copyPPSJobNum_Code"/>
	<antcall target="copyPPSJobNum_Script"/>
	<antcall target="copyPPSJobNum_Config"/>
	<antcall target="copyPPSJobNum_Skills"/>
	<antcall target="copyPPSJobNum_Unique"/>
	<antcall target="copyPPSJobNum_Lib"/>
	<antcall target="copyPPSJobNum_fileUtilities"/>
	<antcall target="copyPPSJobNum_TWS_SIMULATOR"/>
	<antcall target="copyPPSJobNum_lib_VER2"/>
	<antcall target="copyPPSJobNum_jar_VER2"/>
	<antcall target="copyPPSJobNum_lib_VER3"/>


  <antcall target="PPSJobNumBuildTar"/>
  <tstamp>
    <format property="end_target7.timestamp" pattern="dd-MMM-yy HH:mm:ss"/>
  </tstamp>

  <echo message="End - copyPPSJobNum(${jobNum}) : ${end_target7.timestamp}"/>
</target>


<target name="build" depends="copyPPSJobNum"/>
<target name="all" depends="init,build"/>

</project>
